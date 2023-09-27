//
//  ChampionDetailRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import Foundation
import RxSwift
import RxCocoa

struct ChampionDetailRepository: CommonRepositoryProtocol {

    func getLayoutStatusList() -> Observable<[ChampionDetailLayoutStatus]> {
        Observable.just([
            .blur,
            .description,
            .skill(skillStatus: .passive),
            .skill(skillStatus: .qSkill),
            .skill(skillStatus: .wSkill),
            .skill(skillStatus: .eSkill),
            .skill(skillStatus: .rSkill),
        ])
    }

    func getChampionDetailPageAttribute(championID: String) -> Observable<ChampionDetailPageAttribute> {
        riotAPI.getChampionDtail(championID: championID)
            .flatMap { [self] championDetail in
                guard let championDetail = championDetail else { return Observable<ChampionDetailPageAttribute>.empty() }

                let skinList = self.convertToSkin(championDetail: championDetail)
                let skills = self.convertToSkill(championDetail: championDetail)
                let tagList = championDetail.tags

                let result = ChampionDetailPageAttribute(
                    skinList: skinList,
                    championName: championDetail.name ?? "",
                    championTitle: championDetail.title ?? "",
                    championDescription: championDetail.lore ?? "",
                    championTagList: tagList,
                    skillList: skills
                )
                return Observable.just(result)
            }
            .catch { _ in
                Observable<ChampionDetailPageAttribute>.empty()
            }
    }

    private func convertToSkin(championDetail: RiotChampionDetailResult) -> [ChampionDetailSkinAttribute] {
        let skins = championDetail.skins.map { skin in
            ChampionDetailSkinAttribute(
                skinName: skin.name ?? "",
                skinImageURL: RiotAPIRequestContext.getChampionImageURL(
                    championImageSizeStatus: .full,
                    championID: championDetail.id,
                    skinIndexNumber: skin.num
                )
            )
        }
        return Array(skins[1..<skins.count]).shuffled()
    }

    private func convertToSkill(championDetail: RiotChampionDetailResult) -> [ChampionDetailSkillAttribute] {
        var skillList: [ChampionDetailSkillAttribute] = []
        let passive = ChampionDetailSkillAttribute(
            skillStatus: .passive,
            skillImageURL: RiotAPIRequestContext.getPassiveImageURL(passiveImagePath: championDetail.passive.passiveImagePath),
            skillName: championDetail.passive.name ?? "",
            skillDescription: championDetail.passive.description ?? ""
        )
        skillList.append(passive)
        let skills = championDetail.spells.enumerated().map { index, spell in
            var skillStatus: LOLSkillStatus = .qSkill
            switch index {
            case 0: skillStatus = .qSkill
            case 1: skillStatus = .wSkill
            case 2: skillStatus = .eSkill
            case 3: skillStatus = .rSkill
            default:break
            }
            return ChampionDetailSkillAttribute(
                skillStatus: skillStatus,
                skillImageURL: RiotAPIRequestContext.getSpellImageURL(spellID: spell.id),
                skillName: spell.name ?? "",
                skillDescription: spell.description ?? ""
            )
        }
        skillList += skills
        return skillList
    }
    
}
