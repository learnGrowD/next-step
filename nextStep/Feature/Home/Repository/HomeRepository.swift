//
//  HomeRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeRepository: CommonRepositoryProtocol {
    func getLayouts() -> Observable<[HomeLayoutStatus]> {
        let willdInformationBetweenAttribute = HomeBetweenBannerAttribute.getMockupData()
        return Observable.just([
            .small(lolChampionTagCategory: .assassin),
            .betweenBanner(betweenBannerAttribute: willdInformationBetweenAttribute),
            .small(lolChampionTagCategory: .fighter),
            .small(lolChampionTagCategory: .tank),
            .large(lolChampionTagCategory: .mage),
            .large(lolChampionTagCategory: .support),
        ])
    }

    func getBannerList() -> Observable<[HomeBannerItemAttribute]> {
        let sequence = HomeBannerItemAttribute.getMocupData().shuffled()
        return Observable.just(sequence)
    }

    func getCategory() -> Observable<[HomeChampionCategoryAttribute]> {
        riotAPI.getChampionList()
            .map {
                var result: [HomeChampionCategoryAttribute] = []
                $0.forEach { champion in
                    champion.tagCategoys.forEach { tagCategory in
                        let value = HomeChampionCategoryAttribute(
                            id: champion.id ?? "",
                            category: tagCategory,
                            thumbnailImageURL: champion.image?.full ?? "",
                            championName: champion.name ?? "",
                            title: champion.title ?? ""
                        )
                        result.append(value)
                    }
                }
                return result.shuffled()
            }
            .catch { _ in
                Observable<[HomeChampionCategoryAttribute]>.empty()
            }

    }
}
