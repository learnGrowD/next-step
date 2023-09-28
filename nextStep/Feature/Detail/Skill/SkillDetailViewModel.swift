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
    let championKey: String
    let skillKey: String
    let championName: String
    let skillName: String
    init(championKey: String, skillKey: String, championName: String, skillName: String) {
        self.championKey = championKey
        self.skillKey = skillKey
        self.championName = championName
        self.skillName = skillName
        super.init()
    }

    func getSkillTitle() -> Observable<String> {
        Observable.just("\(championName) - \(skillName)")
    }
}
