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
struct CommonAPIService<Wrapper: APIWrapperProtocol> {
    private let requestContext: APIRequestContextProtocol
    init(requestContext: APIRequestContextProtocol) {
        self.requestContext = requestContext
    }

    func request(method: HTTPMethod) -> Observable<Wrapper.Data> {
        //MARK: RequestUIMode 처리

        var optionalDisposeBag: DisposeBag? = DisposeBag()
        let subject = PublishSubject<Wrapper.Data>()

        guard let disposeBag = optionalDisposeBag else { return Observable<Wrapper.Data>.empty() }

        subject
            .subscribe()
            .disposed(by: disposeBag)

        let _ = responseData(methode: method)
            .do(onSubscribe: {
                //MARK: RequestUIMode 처리
                print("subscribe")
            }).map { [self] in
                //MARK: RequestUIMode 처리
                let statusCode = $0.0.statusCode
                let data = $0.1
                optionalDisposeBag = nil
                do {
                    return try self.result(statusCode: statusCode, data: data)
                } catch {
                    throw error
                }
            }
            .catch {
                let message = "🚨 request error: [requestURL: \(requestContext.requestURL), errorMessage: \($0.localizedDescription)]"
                print(message)
                throw NetworkError.clientError(message)
            }
            .subscribe(subject)

        return subject
    }

    private func responseData(methode: HTTPMethod) -> Observable<(HTTPURLResponse, Data)> {
        AF.request(
            requestContext.requestURL,
            method: methode,
            parameters: requestContext.params,
            encoding: requestContext.encoding,
            headers: requestContext.headers
        ).rx.responseData()
    }

    private func result(statusCode: Int, data: Data) throws -> Wrapper.Data {
        //MARK: ResponseUIMode 처리
        if 200..<300 ~= statusCode {
            do {
                let api = try JSONDecoder().decode(Wrapper.self, from: data)
                if api.resultCode == requestContext.resultCode {
                    guard let data = api.data else { throw NetworkError.resultDataIsNull(api.resultCode, api.resultMessage) }
                    return data
                } else {
                    print("🚨 resultCode is not success [resultCode: \(api.resultCode ?? ""), resultMessage: \(api.resultMessage ?? "")]")
                    throw NetworkError.serverError(api.resultCode, api.resultMessage)
                }
            } catch {
                let message = "json parsing error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL), errorMessage: \(error.localizedDescription)]"
                print("🚨 \(message)")
                throw NetworkError.jsonParsingError(message)
            }
        }

        if statusCode == 403 {
            //MARK: Autho Error 규격에 맞게 다시 설계하면 좋을것 같다.
            let message = "authorization error"
            print("🚨 \(message)")
            throw NetworkError.authorizationError(message)
        }

        if 400..<500 ~= statusCode {
            let message = "client error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
            print("🚨 \(message)")
            throw NetworkError.clientError(message)
        }

        if 500..<600 ~= statusCode {
            //MARK: 500 Error 규격에 맞게 다시 설계하면 좋을것 같다.
            do {
                let api = try JSONDecoder().decode(Wrapper.self, from: data)
                throw NetworkError.serverError(api.resultCode, api.resultMessage)
            } catch {
                let message = "json parsing error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL), errorMessage: \(error.localizedDescription)]"
                print("🚨 \(message)")
                throw NetworkError.jsonParsingError(message)
            }
        }
        let message = "unkownError error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
        print("🚨 \(message)")
        throw NetworkError.unkownError(message)
    }
}
