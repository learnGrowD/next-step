//
//  Array+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
