//
//  HomeLayoutCategory.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/20.
//

import Foundation

enum HomeLayoutCategory {
    case banner
    case betweenBanner
    case small(lolChampionTagCategory: LOLChampionTagCategory)
    case large(lolChampionTagCategory: LOLChampionTagCategory)
}
