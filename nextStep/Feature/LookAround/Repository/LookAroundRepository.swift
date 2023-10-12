//
//  LookAroundRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import Foundation
import RxSwift
import RxCocoa

class LookAroundRepository: CommonRepositoryProtocol {

    func getLayoutList() -> Observable<[LookAroundLayoutStatus]> {
        let chartListMockupList = LookAroundChartAttribute.getMockupList()
        return Observable.just([
            .chart(lookAroundChartAttribute: chartListMockupList[0]),
            .chart(lookAroundChartAttribute: chartListMockupList[1]),
            .interestedGroup(interestedStatus: .tier),
            .interestedGroup(interestedStatus: .position),
        ])
    }

    func getChartChampionList() -> Observable<[LookAroundChampionRankAttribute]> {
        riotAPI.getChampionList()
            .map { championList in
                var result: [LookAroundChampionRankAttribute] = []
                championList.forEach { champion in
                    champion.tagCategoys.forEach { tag in
                        let newElement = LookAroundChampionRankAttribute(
                            id: champion.id ?? "",
                            championTagCategory: tag,
                            championImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .small, championID: champion.id),
                            championName: champion.name ?? "",
                            champioDescription: champion.title ?? ""
                        )
                        result.append(newElement)
                    }
                }
                let shuffledList = result.shuffled()
                return shuffledList
            }
            .catch { _ in
                Observable.just([])
            }
    }

    func getInterestedGroupList() -> Observable<[LookAroundInterestedGroupAttribute]> {
        let mockupList = LookAroundInterestedGroupAttribute.getMockupDataList()
        return Observable<[LookAroundInterestedGroupAttribute]>.just(mockupList)
    }
}
