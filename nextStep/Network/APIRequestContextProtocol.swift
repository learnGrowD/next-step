//
//  NetworkContextProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import Alamofire

protocol APIRequestContextProtocol {
    static var baseURL: String { get }
    var serverName: String { get }
    var resultCode: String? { get }

    var requestURL: String { get set }
    var params: [String: Any] { get set }
    var multipartFormDatas: [MultipartFormData] { get set }
    var requestUIMode: APIRequestUIMode { get set }
    var resultUIMode: APIResultUIMode { get set }
    
    var headers: HTTPHeaders { get set }
}


