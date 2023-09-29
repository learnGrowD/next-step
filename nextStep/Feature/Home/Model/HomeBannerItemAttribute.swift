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
                categoryText: R.string.localizable.homeTalonRecommend(),
                title: R.string.localizable.homeTalonTitle(),
                allCount: 11,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 39),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 29),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Talon", skinIndexNumber: 20),
                ],
                championInformation: "Talon - \(R.string.localizable.homeTalonTitle())"
            ),
            HomeBannerItemAttribute(
                id: "Ezreal",
                key: "81",
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal"),
                categoryText: R.string.localizable.homeEzrealRecommend(),
                title: R.string.localizable.homeEzrealTitle(),
                allCount: 18,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 20),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 25),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ezreal", skinIndexNumber: 19),
                ],
                championInformation: "Ezreal - \(R.string.localizable.homeEzrealTitle())"
            ),
            HomeBannerItemAttribute(
                id: "Diana",
                key: "131",
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana"),
                categoryText: R.string.localizable.homeDianaRecommend(),
                title: R.string.localizable.homeDianaTitle(),
                allCount: 12,
                date: Date(),
                skinImageURLList: [
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 26),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 37),
                    RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Diana", skinIndexNumber: 47),
                ],
                championInformation: "Diana - \(R.string.localizable.homeDianaTitle())"
            ),
        ]
    }
}
