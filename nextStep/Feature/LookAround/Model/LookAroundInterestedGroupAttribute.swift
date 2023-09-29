//
//  LookAroundInterestedGroupAttribute.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import UIKit

struct LookAroundInterestedGroupAttribute {
    let id: Int
    let status: LookAroundInterestedStatus
    let backgroundImageURL: String?
    let iconImageUIImage: UIImage?
    let title: String

    static func getMockupDataList() -> [LookAroundInterestedGroupAttribute] {
        [
            LookAroundInterestedGroupAttribute(
                id: 0,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Aatrox", skinIndexNumber: 20),
                iconImageUIImage: R.image.tierIron(),
                title: R.string.localizable.lookAroundIron()
            ),
            LookAroundInterestedGroupAttribute(
                id: 1,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Alistar", skinIndexNumber: 10),
                iconImageUIImage: R.image.tierBronze(),
                title: R.string.localizable.lookAroundBronze()
            ),
            LookAroundInterestedGroupAttribute(
                id: 2,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ashe", skinIndexNumber: 63),
                iconImageUIImage: R.image.tierSilver(),
                title: R.string.localizable.lookAroundSilver()
            ),
            LookAroundInterestedGroupAttribute(
                id: 3,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "AurelionSol", skinIndexNumber: 21),
                iconImageUIImage: R.image.tierGold(),
                title: R.string.localizable.lookAroundGold()
            ),
            LookAroundInterestedGroupAttribute(
                id: 4,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Bard", skinIndexNumber: 17),
                iconImageUIImage: R.image.tierPlatinum(),
                title: R.string.localizable.lookAroundPlatinum()
            ),
            LookAroundInterestedGroupAttribute(
                id: 5,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ekko", skinIndexNumber: 19),
                iconImageUIImage: R.image.tierDiamond(),
                title: R.string.localizable.lookAroundDiamond()
            ),
            LookAroundInterestedGroupAttribute(
                id: 6,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Elise", skinIndexNumber: 5),
                iconImageUIImage: R.image.tierGrandmaster(),
                title: R.string.localizable.lookAroundGrandmaster()
            ),
            LookAroundInterestedGroupAttribute(
                id: 7,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Galio", skinIndexNumber: 2),
                iconImageUIImage: R.image.tierMaster(),
                title: R.string.localizable.lookAroundMaster()
            ),
            LookAroundInterestedGroupAttribute(
                id: 8,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kalista", skinIndexNumber: 1),
                iconImageUIImage: R.image.tierChallenger(),
                title: R.string.localizable.lookAroundChallenger()
            ),

            LookAroundInterestedGroupAttribute(
                id: 9,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Karthus", skinIndexNumber: 26),
                iconImageUIImage: R.image.positionTop(),
                title: R.string.localizable.lookAroundTop()
            ),

            LookAroundInterestedGroupAttribute(
                id: 10,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kassadin", skinIndexNumber: 5),
                iconImageUIImage: R.image.positionJungle(),
                title: R.string.localizable.lookAroundJungle()
            ),

            LookAroundInterestedGroupAttribute(
                id: 11,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kayn", skinIndexNumber: 2),
                iconImageUIImage: R.image.positionMiddle(),
                title: R.string.localizable.lookAroundMiddle()
            ),

            LookAroundInterestedGroupAttribute(
                id: 12,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Lillia", skinIndexNumber: 19),
                iconImageUIImage: R.image.positionBottom(),
                title: R.string.localizable.lookAroundBottom()
            ),

            LookAroundInterestedGroupAttribute(
                id: 13,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Malphite", skinIndexNumber: 23),
                iconImageUIImage: R.image.positionSupport(),
                title: R.string.localizable.lookAroundSupport()
            ),
        ]
    }
}
