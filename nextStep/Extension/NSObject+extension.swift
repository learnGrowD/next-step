//
//  NSObject+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

extension NSObject {
    static var tag: String {
        String(describing: String(describing: Self.self))
    }

    static var className: String {
        String(describing: String(describing: type(of: self)))
    }

    var tag: String {
        NSObject.tag
    }

    var className: String {
        NSObject.className
    }

    func printMemoryAdress() {
        #if DEBUG
        print("\(Self.className) Memory Adress: \(Unmanaged.passUnretained(self).toOpaque())")
        #endif
    }
}
