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
    let championID: String
    let layoutStatusList = BehaviorRelay<[ChampionDetailLayoutStatus]>(value: [])
    let championDetailData = BehaviorRelay<ChampionDetailPageAttribute?>(value: nil)

    init(championID: String) {
        self.championID = championID
        super.init()
        bind()
    }

    func getLayoutStatusList() -> Observable<[ChampionDetailLayoutStatus]> {
        layoutStatusList
            .asObservable()
    }

    func getSkinImageURLList() -> Observable<[ChampionDetailSkinAttribute]> {
        championDetailData
            .map {
                $0?.skinList ?? []
            }
    }

    func getChampionDescription() -> Observable<ChampionDetailDescriptionAttribute> {
        championDetailData
            .map {
                ChampionDetailDescriptionAttribute(
                    tagList: $0?.championTagList ?? ["Common"],
                    championName: $0?.championName ?? "",
                    championTItle: $0?.championTitle ?? "",
                    championDescription: $0?.championDescription ?? ""
                )
            }
    }

    func getChampionDescriptionPrimitive() -> ChampionDetailDescriptionAttribute? {
        championDetailData.value
            .map {
                ChampionDetailDescriptionAttribute(
                    tagList: $0.championTagList,
                    championName: $0.championName,
                    championTItle: $0.championTitle,
                    championDescription: $0.championDescription
                )
            }
    }

    private func bind(_ repository: ChampionDetailRepository = ChampionDetailRepository()) {
        repository.getLayoutStatusList()
            .take(1)
            .bind(to: layoutStatusList)
            .disposed(by: disposeBag)

        repository.getChampionDetailPageAttribute(championID: championID)
            .take(1)
            .bind(to: championDetailData)
            .disposed(by: disposeBag)
    }
}
