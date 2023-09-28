//
//  SkillDetailViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/28.
//

import Foundation
import RxSwift
import RxCocoa

final class SkillDetailViewModel: BaseViewModel {
    let skillAttribute: ChampionDetailSkillAttribute
    init(skillAttribute: ChampionDetailSkillAttribute) {
        self.skillAttribute = skillAttribute
        super.init()
    }

    func getSkillTitle() -> Observable<String> {
        Observable.just("\(skillAttribute.championName) - \(skillAttribute.skillName)")
    }

    func getSkillImageURL() -> Observable<String?> {
        Observable.just(skillAttribute)
            .map { $0.skillImageURL }
    }

    func getSkillKey() -> Observable<String> {
        Observable.just(skillAttribute)
            .map { $0.skillStatus.rawValue }
    }

    func getSkillName() -> Observable<String> {
        Observable.just(skillAttribute)
            .map { $0.skillName }
    }

    func getSkillDescription() -> Observable<String> {
        Observable.just(skillAttribute)
            .map { $0.skillDescription }
    }
    func getSkillVideoURLWithMp4() -> Observable<String?> {
        Observable.just(skillAttribute)
            .map {
                RiotAPIRequestContext.getChampionSkillVedioURLWithMp4(
                    championKey: $0.championKey,
                    skillStatus: $0.skillStatus
                )
            }
    }
}
