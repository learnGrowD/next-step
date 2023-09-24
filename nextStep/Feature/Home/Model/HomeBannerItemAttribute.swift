//
//  HomeBannerItemAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

struct HomeBannerItemAttribute {
    let id: String
    let key: String
    let backgroundImageURL: String?
    let categoryText: String
    let title: String
    let allCount: Int
    let date: Date
    let skinImageURLList: [String?]
    let championInformation: String

    static func getMocupData() -> [HomeBannerItemAttribute] {
        [
            HomeBannerItemAttribute(
                id: "Talon",
                key: "91",
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon"),
                categoryText: "데일리 추천",
                title: "검의 그림자",
                allCount: 11,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 39),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 29),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 20),
                ],
                championInformation: "Talon - 검의 그림자"
            ),
            HomeBannerItemAttribute(
                id: "Ezreal",
                key: "81",
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal"),
                categoryText: "will_d 추천",
                title: "무모한 탐험가",
                allCount: 18,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 20),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 25),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 19),
                ],
                championInformation: "Ezreal - 무모한 탐험가"
            ),
            HomeBannerItemAttribute(
                id: "Diana",
                key: "131",
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana"),
                categoryText: "will_d 추천",
                title: "차가운 달의 분노",
                allCount: 12,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 26),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 37),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 47),
                ],
                championInformation: "Diana - 차가운 달의 분노"
            ),
        ]
    }
}
