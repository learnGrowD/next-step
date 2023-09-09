//
//  Codable+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String:Any]? {
        var dict: [String: Any]?
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dict
    }
}
