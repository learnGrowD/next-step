//
//  MainTapBarCategory.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

enum MainTapBarCategory {
    case home
    case lookAround
    case gallery

    static func getCategory(index: Int?) -> MainTapBarCategory {
        switch index {
        case 0:
            return MainTapBarCategory.home
        case 1:
            return MainTapBarCategory.lookAround
        case 2:
            return MainTapBarCategory.gallery
        default:
            return MainTapBarCategory.home
        }
    }
}
