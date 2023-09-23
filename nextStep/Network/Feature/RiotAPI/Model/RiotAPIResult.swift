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
    let image: Image?
    let tags: [String]
    var tagCategoys: [LOLChampionTagCategory] {
        var result: [LOLChampionTagCategory] = []
        tags.forEach {
            let value = LOLChampionTagCategory.getLOLChampionTagCategory(tagString: $0)
            result.append(value)
        }
        return result
    }
    
    struct Image: Codable {
        let full: String?
        let sprite: String?
        let group: String?
    }
}
