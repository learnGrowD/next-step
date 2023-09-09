//
//  NetworkContextProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import Alamofire


//resultCode
//url
//encoding
//headers


//path
//requestUI
//resultUI
//params
//method
protocol APIRequestContextProtocol {
    var resultCode: String { get }
    static var baseURL: String { get }

    var requestURL: String { get set }
    var params: [String: Any] { get set }
    var requestUIMode: APIRequestUIMode { get set }
    var resultUIMode: APIResultUIMode { get set }

    var encoding: ParameterEncoding { get set }
    var headers: HTTPHeaders { get set }
}
