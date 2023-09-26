//
//  ChampionDetailViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import Foundation
import RxSwift
import RxCocoa

final class ChampionDetailViewModel: BaseViewModel {
    let layoutStatusList = BehaviorRelay<[ChampionDetailLayoutStatus]>(value: [])

    init(championID: String) {
        super.init()
    }

    func getLayoutStatusList() -> Observable<[ChampionDetailLayoutStatus]> {
        layoutStatusList
            .filter { !$0.isEmpty }
    }

    func getSkinImageURLList() -> [String] {

    }

    private func bind(_ repository: ChampionDetailRepository = ChampionDetailRepository()) {
        repository.getLayoutStatusList()
            .take(1)
            .bind(to: layoutStatusList)
            .disposed(by: disposeBag)
    }
}
