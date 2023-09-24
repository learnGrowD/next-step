//
//  HomeBetweenBannerAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit

struct HomeBetweenBannerAttribute {
    let backgroundImageURL: String?
    let webURL: String
    let title: String
    let description: String
    let decorateIconImage: UIImage?

    static func getMockupData() -> HomeBetweenBannerAttribute {
        HomeBetweenBannerAttribute(
            backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(
                championImageSizeStatus: .full,
                championID: "Talon",
                skinIndexNumber: 39
            ),
            webURL: "https://velog.io/@will_d/about",
            title: "will_d",
            description: "자세히 한번 알아볼까요?",
            decorateIconImage: R.image.tierDiamond()
        )
    }
}
