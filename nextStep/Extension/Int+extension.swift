//
//  Int+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import Foundation

extension Int {
    func convertNumberWithZeros() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 4
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
