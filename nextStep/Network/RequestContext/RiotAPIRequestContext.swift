//
//  RiotAPIRequestContext.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import Alamofire

class RiotAPIRequestContext: APIRequestContextProtocol {
    static var baseURL: String {
        AppConfigure.isProductRelease ? "" : ""
    }

    var resultCode: String {
        ""
    }

    var requestURL: String

    var params: [String : Any]

    var requestUIMode: APIRequestUIMode

    var resultUIMode: APIResultUIMode

    var encoding: ParameterEncoding

    var headers: HTTPHeaders

    init(
        path: String,
        params: [String: Any],
        requestUIMode: APIRequestUIMode,
        resultUIMode: APIResultUIMode,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders = ["Content-Type": "application/json"]) {
            self.requestURL = "\(RiotAPIRequestContext.baseURL)/\(path)"
            self.params = params
            self.requestUIMode = requestUIMode
            self.resultUIMode = resultUIMode
            self.encoding = encoding
            self.headers = headers
        }
}
