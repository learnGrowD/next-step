//
//  GalleryInformationAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import Foundation

struct GalleryInformationAttribute {
    let informationStatus: GalleyInformationStatus
    let iconImageName: String
    let description: String
    let link: String

    static func getMockUpData() -> [GalleryInformationAttribute] {
        [GalleryInformationAttribute(
            informationStatus: .phone,
            iconImageName: "link",
            description: "phoen",
            link: "010-8705-1693"
        ),
        GalleryInformationAttribute(
            informationStatus: .web,
            iconImageName: "link",
            description: "gitHub",
            link: "https://github.com/learnGrowD"
        ),
        GalleryInformationAttribute(
            informationStatus: .web,
            iconImageName: "link",
            description: "blog",
            link: "https://velog.io/@will_d"
        ),
        GalleryInformationAttribute(
            informationStatus: .web,
            iconImageName: "link",
            description: "Next-step",
            link: "https://github.com/learnGrowD/next-step"
        )]
    }
}
