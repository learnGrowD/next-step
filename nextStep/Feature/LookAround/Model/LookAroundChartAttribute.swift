//
//  LookAroundChartAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import Foundation

struct LookAroundChartAttribute {
    let title: String
    let subTitle: String
    let description: String
    let championTagCategory: LOLChampionTagCategory

    static func getMockupList() -> [LookAroundChartAttribute] {
        [
            LookAroundChartAttribute(
                title: "will_d 차트",
                subTitle: "\(Date().toString(format: "yyyy-MM-dd")) 기준",
                description: "will_d가 추천하는 assass",
                championTagCategory: .assassin
            ),
            LookAroundChartAttribute(
                title: "서포터는 뭐가 좋을까?",
                subTitle: "\(Date().toString(format: "yyyy-MM-dd")) 기준",
                description: "좋은 서포터를 한 눈에!",
                championTagCategory: .support
            ),
        ]
    }
}
