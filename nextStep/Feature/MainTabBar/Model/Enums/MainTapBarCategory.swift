//
//  MainTapBarCategory.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

enum MainTapBarCategory: Int {
    case home = 0
    case lookAround = 1
    case gallery = 2

    static func getCategory(index: Int?) -> MainTapBarCategory {
        switch index {
        case MainTapBarCategory.home.rawValue:
            return MainTapBarCategory.home
        case MainTapBarCategory.lookAround.rawValue:
            return MainTapBarCategory.lookAround
        case MainTapBarCategory.gallery.rawValue:
            return MainTapBarCategory.gallery
        default:
            return MainTapBarCategory.home
        }
    }
}
