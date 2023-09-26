//
//  RiotAPIResult.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import Foundation

struct RiotChampionResult: Codable {
    let id: String?
    let name: String?
    let title: String?
    let blurb: String?
    let tags: [String]
    var tagCategoys: [LOLChampionTagCategory] {
        var result: [LOLChampionTagCategory] = []
        tags.forEach {
            let value = LOLChampionTagCategory.getLOLChampionTagCategory(tagString: $0)
            result.append(value)
        }
        return result
    }
}

struct RiotChampionDetailResult: Codable {
    let id: String?
    let key: String?
    let name: String?
    let title: String?
    let skins: [Skin]
    let lore: String?
    let allytips: [String]
    let enemytips: [String]
    let tags: [String]
    var tagCategoys: [LOLChampionTagCategory] {
        var result: [LOLChampionTagCategory] = []
        tags.forEach {
            let value = LOLChampionTagCategory.getLOLChampionTagCategory(tagString: $0)
            result.append(value)
        }
        return result
    }
    let spells: [Spell]
    let passive: Passive

    struct Skin: Codable {
        let id: String?
        let num: Int?
        let name: String?
    }
    struct Spell: Codable {
        let id: String?
        let name: String?
        let description: String?
    }
    struct Passive: Codable {
        let name: String?
        let description: String?
        private let image : Image?
        var passiveImagePath: String? {
            image?.full
        }

        struct Image: Codable {
            let full: String?
        }
    }
}
