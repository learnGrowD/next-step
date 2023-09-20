//
//  Date+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/20.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let result = dateFormatter.string(from: self)
        return result
    }
}
