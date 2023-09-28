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
}
