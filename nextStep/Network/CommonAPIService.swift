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

//한건의 Request를 담당
struct CommonAPIService<Wrapper: APIWrapperProtocol> {
    let requestContext: APIRequestContextProtocol
    init(requestContext: APIRequestContextProtocol) {
        self.requestContext = requestContext
    }

    func getMethod() -> Observable<Result<Wrapper, NetworkError>> {
        request(method: .get)
    }

    func postMethod() -> Observable<Result<Wrapper, NetworkError>> {
        request(method: .post)
    }

    func deleteMethod() -> Observable<Result<Wrapper, NetworkError>> {
        request(method: .delete)
    }

    func patchMethod() -> Observable<Result<Wrapper, NetworkError>> {
        request(method: .patch)
    }

    func putMethod() -> Observable<Result<Wrapper, NetworkError>> {
        request(method: .put)
    }

    private func request(method: HTTPMethod) -> Observable<Result<Wrapper, NetworkError>> {
        //MARK: RequestUIMode 처리

        var optionalDisposeBag: DisposeBag? = DisposeBag()
        let subject = PublishSubject<Result<Wrapper, NetworkError>>()

        guard let disposeBag = optionalDisposeBag else {
            return Observable.just(.failure(.clientError("disposeBag is null")))
        }

        subject
            .subscribe()
            .disposed(by: disposeBag)

        let _ = responseData(methode: .get)
            .do(onSubscribe: {
                //MARK: RequestUIMode 처리
                print("subscribe")
            }).map { [self] in
                //MARK: RequestUIMode 처리
                let statusCode = $0.0.statusCode
                let data = $0.1
                optionalDisposeBag = nil
                return self.result(statusCode: statusCode, data: data)
            }
//            .catch {
//                //MARK: RequestUIMode 처리
//
//            }
            .subscribe(subject)

        return subject
    }

    private func responseData(methode: HTTPMethod) -> Observable<(HTTPURLResponse, Data)> {
        AF.request(
            requestContext.requestURL,
            method: .get,
            parameters: requestContext.params,
            encoding: requestContext.encoding,
            headers: requestContext.headers
        ).rx.responseData()
    }

    private func result(statusCode: Int, data: Data) -> Result<Wrapper, NetworkError> {
        //MARK: ResponseUIMode 처리
        if 200..<300 ~= statusCode {
            do {
                let api = try JSONDecoder().decode(Wrapper.self, from: data)
                if api.resultCode == requestContext.resultCode {
                    return .success(api)
                } else {
                    return .failure(.serverError(api.resultCode, api.resultMessage))
                }
            } catch {
                let message = "json parsing error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
                return .failure(.jsonParsingError(message))
            }
        }

        if statusCode == 403 {
            //MARK: Autho Error 규격에 맞게 다시 설계하면 좋을것 같다.
            let message = "authorization error"
            return .failure(.authorizationError(message))
        }

        if 400..<500 ~= statusCode {
            let message = "client error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
            return .failure(.clientError(message))
        }

        if 500..<600 ~= statusCode {
            //MARK: 500 Error 규격에 맞게 다시 설계하면 좋을것 같다.
            do {
                let api = try JSONDecoder().decode(Wrapper.self, from: data)
                return .failure(.serverError(api.resultCode, api.resultMessage))
            } catch {
                let message = "json parsing error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
                return .failure(.jsonParsingError(message))
            }
        }
        let message = "unkownError error [statusCode: \(statusCode), requestApi: \(requestContext.requestURL)]"
        return .failure(.unkownError(message))

    }
}
