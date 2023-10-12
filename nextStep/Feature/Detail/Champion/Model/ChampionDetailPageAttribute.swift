//
//  ChampionDetailPageAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import Foundation

struct ChampionDetailPageAttribute {
    let skinList: [ChampionDetailSkinAttribute]
    let championName: String
    let championTitle: String
    let championDescription: String
    let championTagList: [String]
    var isLike: Bool
    let skillList: [ChampionDetailSkillAttribute]
}
