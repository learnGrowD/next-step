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
    static let shared = HomeRepository()

    func getLayouts() -> Observable<[HomeLayoutCategory]> {
        Observable.just([
            .banner,
            .small(lolChampionTagCategory: .assassin),
            .small(lolChampionTagCategory: .fighter),
            .small(lolChampionTagCategory: .tank),
            .small(lolChampionTagCategory: .mage),
            .small(lolChampionTagCategory: .support),
        ])
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
                return result
            }

    }
}
