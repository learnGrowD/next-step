//
//  LookAroundViewmodelk.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import Foundation
import RxSwift
import RxCocoa

final class LookAroundViewModel: BaseViewModel {
    let layoutStatusList = BehaviorRelay<[LookAroundLayoutStatus]>(value: [])
    let topCategoryList = BehaviorRelay<[LookAroundCategoryAttribute]>(value: [])
    let topCategoryButtonTap = PublishRelay<LookAroundCategoryAttribute>()

    override init() {
        super.init()
        bind()
    }

    func getLayoutStatusList() -> Observable<[LookAroundLayoutStatus]> {
        layoutStatusList
            .filter { !$0.isEmpty }
    }

    func getTopCategoryList() -> Observable<[LookAroundCategoryAttribute]> {
        topCategoryList
            .filter { !$0.isEmpty }
    }

    func getTopCategoryButtonTapWithLayoutPositionIndex() -> Observable<Int> {
        topCategoryButtonTap
            .map { $0.index }
    }


    func getChartCategoryTitle(chartCategory: LOLChampionTagCategory) -> String? {
        switch chartCategory {
        case .assassin:
            return R.string.localizable.lookAroundViewModelChartCategoryAssassinTitle()
        case .fighter:
            return R.string.localizable.lookAroundViewModelChartCategoryFighterTitle()
        case .mage:
            return R.string.localizable.lookAroundViewModelChartCategoryMageTitle()
        case .marksman:
            return R.string.localizable.lookAroundViewModelChartCategoryMarksmanTitle()
        case .support:
            return R.string.localizable.lookAroundViewModelChartCategorySupportTitle()
        case .tank:
            return R.string.localizable.lookAroundViewModelChartCategoryTankTitle()
        }
    }

    func getInterestedStatusTitle(interestedState: LookAroundInterestedStatus) -> String? {
        switch interestedState {
        case .position:
            return R.string.localizable.lookAroundViewModelInterestedStatusPositionTitle()
        case .tier:
            return R.string.localizable.lookAroundViewModelInterestedStatusTierTitle()
        }
    }

    private func bind(_ repository: LookAroundRepository = LookAroundRepository()) {
        repository.getLayoutList()
            .take(1)
            .bind(to: layoutStatusList)
            .disposed(by: disposeBag)

        bindTopCategoryList()
            .take(1)
            .bind(to: topCategoryList)
            .disposed(by: disposeBag)
    }

    private func bindTopCategoryList() -> Observable<[LookAroundCategoryAttribute]> {
        layoutStatusList
            .map { statusList in
                statusList.enumerated().map { [weak self] index ,status in
                    switch status {
                    case .chart(championTagCategory: let category):
                        return LookAroundCategoryAttribute(
                            index: index,
                            categoryText: self?.getChartCategoryTitle(chartCategory: category)
                        )
                    case .interestedGroup(interestedStatus: let status):
                        return LookAroundCategoryAttribute(
                            index: index,
                            categoryText: self?.getInterestedStatusTitle(interestedState: status)
                        )
                    }
                }
            }
    }
}
