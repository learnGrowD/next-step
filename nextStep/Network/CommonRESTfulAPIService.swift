//
//  A.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa

// 한건의 Request를 담당
// *** API Request 추상화
struct CommonRESTfulAPIService<Wrapper: APIWrapperProtocol> {
    private let requestContext: APIRequestContextProtocol
    init(requestContext: APIRequestContextProtocol) {
        self.requestContext = requestContext
    }

    func getMapping() -> Observable<Wrapper.Data> {
        request(method: .get, encoding: URLEncoding.default)
    }

    func postMapping() -> Observable<Wrapper.Data> {
        request(method: .post, encoding: JSONEncoding.default)
    }

    func deleteMapping() -> Observable<Wrapper.Data> {
        request(method: .delete, encoding: URLEncoding.default)
    }

    func patchMappding() -> Observable<Wrapper.Data> {
        request(method: .patch, encoding: JSONEncoding.default)
    }

    private func request(method: HTTPMethod, encoding: ParameterEncoding) -> Observable<Wrapper.Data> {
        //MARK: RequestUIMode 처리
        let subject = PublishSubject<Wrapper.Data>()

        let _ = subject
            .take(1)
            .subscribe()

        let _ = responseData(methode: method, encoding: encoding)
            .do(onSubscribe: {
                //MARK: RequestUIMode 처리
                print("subscribe")
            }).map { [self] in
                //MARK: RequestUIMode 처리
                do {
                    return try self.result(statusCode: $0.0.statusCode, data: $0.1)
                } catch {
                    throw error
                }
            }
            .catch {
                throw requestUnknownError(error: $0)
            }
            .subscribe(subject)
        return subject
    }

    private func responseData(methode: HTTPMethod, encoding: ParameterEncoding) -> Observable<(HTTPURLResponse, Data)> {
        AF.request(
            requestContext.requestURL,
            method: methode,
            parameters: requestContext.params,
            encoding: encoding,
            headers: requestContext.headers
        ).rx.responseData()
    }

    private func result(statusCode: Int, data: Data) throws -> Wrapper.Data {
        //MARK: ResponseUIMode 처리
        let api = try? JSONDecoder().decode(Wrapper.self, from: data)
        if let api = api,
           let apiData = (200..<300 ~= statusCode && api.resultCode == requestContext.resultCode) ? api.data : nil {
            return apiData
        }
        if let api = api,
           200..<300 ~= statusCode && api.resultCode == requestContext.resultCode && api.data == nil {
            throw resultDataIsNull(statusCode: statusCode, api: api)
        }
        if let api = api,
           200..<300 ~= statusCode && api.resultCode != requestContext.resultCode {
            throw resultCodeIsNotSuccess(statusCode: statusCode, api: api)
        }
        if statusCode == 403 {
            throw athorizationIsNotInvalid(statusCode: statusCode)
        }
        if 400..<500 ~= statusCode {
            throw clientError(statusCode: statusCode)
        }
        if let api = api,
           500..<600 ~= statusCode {
            throw serverError(statusCode: statusCode, api: api)
        }
        if api == nil {
            throw jsonParsingError(statusCode: statusCode)
        }
        throw resultUnknownError(statusCode: statusCode)
    }

    private func requestUnknownError(error: Error) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - request unknown error:
        \(errorInformation(requestURL: requestContext.requestURL, errorMessage: error.localizedDescription))
        """
        print(message)
        return error
    }

    private func resultDataIsNull(statusCode: Int, api: Wrapper) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - result data is null:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL,
        resultCode: api.resultCode,
        resultMessage: api.resultMessage
        ))
        """
        print(message)
        return NetworkError.resultDataIsNull(api.resultCode, api.resultMessage)
    }

    private func resultCodeIsNotSuccess(statusCode: Int, api: Wrapper) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - resultCode is not success:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL,
        resultCode: api.resultCode,
        resultMessage: api.resultMessage
        ))
        """
        print(message)
        return NetworkError.serverError(api.resultCode, api.resultMessage)
    }

    private func athorizationIsNotInvalid(statusCode: Int) -> Error {
        //MARK: Autho Error 규격에 맞게 다시 설계하면 좋을것 같다.
        let message = """
        🚨 \(requestContext.serverName) - athorization error:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL
        ))
        """
        print(message)
        return NetworkError.authorizationError(message)
    }

    private func serverError(statusCode: Int, api: Wrapper) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - server error:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL,
        resultCode: api.resultCode,
        resultMessage: api.resultMessage
        ))
        """
        print(message)
        return NetworkError.clientError(message)
    }

    private func clientError(statusCode: Int) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - client error:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL
        ))
        """
        print(message)
        return NetworkError.clientError(message)
    }

    private func jsonParsingError(statusCode: Int) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - json parsing error:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL
        ))
        """
        print(message)
        return NetworkError.jsonParsingError(message)
    }

    private func resultUnknownError(statusCode: Int) -> Error {
        let message = """
        🚨 \(requestContext.serverName) - result unknownError error:
        \(errorInformation(
        statusCode: statusCode,
        requestURL: requestContext.requestURL
        ))
        """
        print(message)
        return NetworkError.unkownError(message)
    }

    private func errorInformation(
        statusCode: Int? = nil,
        requestURL: String? = nil,
        errorMessage: String? = nil,
        resultCode: String? = nil,
        resultMessage: String? = nil
    ) -> String {
        var result = "["
        if let statusCode = statusCode {
            result += "statusCode: \(statusCode), "
        }
        if let requestURL = requestURL {
            result += "requestURL: \(requestURL), "
        }
        if let errorMessage = errorMessage {
            result += "errorMessage: \(errorMessage), "
        }
        if let resultCode = resultCode {
            result += "resultCode: \(resultCode), "
        }
        if let resultMessage = resultMessage {
            result += "resultMessage: \(resultMessage), "
        }
        if result.hasSuffix(", ") {
            result.removeLast(2)
        }
        result += "]"
        return result
    }
}