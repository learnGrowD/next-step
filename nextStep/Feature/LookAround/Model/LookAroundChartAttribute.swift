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
        let dateString = Date().toString(format: "yyyy-MM-dd")
        return [
            LookAroundChartAttribute(
                title: R.string.localizable.lookAroundWilldChartTitle(),
                subTitle: R.string.localizable.lookAroundWilldChartBaseOnTheDate(dateString),
                description: R.string.localizable.lookAroundWilldChartDescription(),
                championTagCategory: .assassin
            ),
            LookAroundChartAttribute(
                title: R.string.localizable.lookAroundSupportChartTitle(),
                subTitle: R.string.localizable.lookAroundSupportChartBaseOnTheDate(dateString),
                description: R.string.localizable.lookAroundSupportChartDescription(),
                championTagCategory: .support
            ),
        ]
    }
}
