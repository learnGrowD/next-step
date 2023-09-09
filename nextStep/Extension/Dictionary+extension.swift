//
//  Dictionary+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

extension Dictionary {
    func toJson() throws -> String? {
        let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    }

    func toArray() -> [Dictionary<Key, Value>.Values.Element] {
        Array(self.values)
    }
}
