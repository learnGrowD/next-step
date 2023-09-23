//
//  LOLChampionTagStatus.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import Foundation

enum LOLChampionTagCategory: String {
    case mage = "Mage"
    case assassin = "Assassin"
    case marksman = "Marksman"
    case tank = "Tank"
    case support = "Support"
    case fighter = "Fighter"

    static func getLOLChampionTagCategory(tagString: String) -> LOLChampionTagCategory {
        switch tagString {
        case LOLChampionTagCategory.mage.rawValue:
            return LOLChampionTagCategory.mage
        case LOLChampionTagCategory.assassin.rawValue:
            return LOLChampionTagCategory.assassin
        case LOLChampionTagCategory.marksman.rawValue:
            return LOLChampionTagCategory.marksman
        case LOLChampionTagCategory.tank.rawValue:
            return LOLChampionTagCategory.tank
        case LOLChampionTagCategory.support.rawValue:
            return LOLChampionTagCategory.support
        case LOLChampionTagCategory.fighter.rawValue:
            return LOLChampionTagCategory.fighter
        default:
            return LOLChampionTagCategory.mage
        }
    }
}

