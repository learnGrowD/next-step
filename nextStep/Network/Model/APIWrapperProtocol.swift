//
//  APIWrapperProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

protocol APIWrapperProtocol: Codable {
    associatedtype Data
    var resultCode: String? {get set}
    var resultMessage: String? {get set}
    var data: Data? {get set}
}

struct RiotWrapper<T: Codable>: APIWrapperProtocol {
    typealias Data = T

    var resultCode: String?

    var resultMessage: String?

    let type: String?

    let format: String?

    let version: String?

    var data: T?
}

