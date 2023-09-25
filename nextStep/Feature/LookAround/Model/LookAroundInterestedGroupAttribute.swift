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
                title: "아이언"
            ),
            LookAroundInterestedGroupAttribute(
                id: 1,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Alistar", skinIndexNumber: 10),
                iconImageUIImage: R.image.tierBronze(),
                title: "브론즈"
            ),
            LookAroundInterestedGroupAttribute(
                id: 2,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ashe", skinIndexNumber: 63),
                iconImageUIImage: R.image.tierSilver(),
                title: "실버"
            ),
            LookAroundInterestedGroupAttribute(
                id: 3,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "AurelionSol", skinIndexNumber: 21),
                iconImageUIImage: R.image.tierGold(),
                title: "골드"
            ),
            LookAroundInterestedGroupAttribute(
                id: 4,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Bard", skinIndexNumber: 17),
                iconImageUIImage: R.image.tierPlatinum(),
                title: "플레티넘"
            ),
            LookAroundInterestedGroupAttribute(
                id: 5,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Ekko", skinIndexNumber: 19),
                iconImageUIImage: R.image.tierDiamond(),
                title: "다이아몬드"
            ),
            LookAroundInterestedGroupAttribute(
                id: 6,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Elise", skinIndexNumber: 5),
                iconImageUIImage: R.image.tierGrandmaster(),
                title: "그랜드마스터"
            ),
            LookAroundInterestedGroupAttribute(
                id: 7,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Galio", skinIndexNumber: 2),
                iconImageUIImage: R.image.tierMaster(),
                title: "마스터"
            ),
            LookAroundInterestedGroupAttribute(
                id: 8,
                status: .tier,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kalista", skinIndexNumber: 1),
                iconImageUIImage: R.image.tierChallenger(),
                title: "챌린저"
            ),

            LookAroundInterestedGroupAttribute(
                id: 9,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Karthus", skinIndexNumber: 26),
                iconImageUIImage: R.image.positionTop(),
                title: "탑"
            ),

            LookAroundInterestedGroupAttribute(
                id: 10,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kassadin", skinIndexNumber: 5),
                iconImageUIImage: R.image.positionJungle(),
                title: "정글"
            ),

            LookAroundInterestedGroupAttribute(
                id: 11,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Kayn", skinIndexNumber: 2),
                iconImageUIImage: R.image.positionMiddle(),
                title: "미드"
            ),

            LookAroundInterestedGroupAttribute(
                id: 12,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Lillia", skinIndexNumber: 19),
                iconImageUIImage: R.image.positionBottom(),
                title: "바텀"
            ),

            LookAroundInterestedGroupAttribute(
                id: 13,
                status: .position,
                backgroundImageURL: RiotAPIRequestContext.getChampionImageURL(championImageSizeStatus: .full, championID: "Malphite", skinIndexNumber: 23),
                iconImageUIImage: R.image.positionSupport(),
                title: "서포터"
            ),
        ]
    }
}
