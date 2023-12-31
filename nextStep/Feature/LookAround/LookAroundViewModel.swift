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

    let isDidScrollEnabled = BehaviorRelay<Bool>(value: true)
    let topCategoryList = BehaviorRelay<[LookAroundCategoryAttribute]>(value: [])
    let topCategoryButtonTap = PublishRelay<LookAroundCategoryAttribute>()

    let chartChampioList = BehaviorRelay<[LookAroundChampionRankAttribute]>(value: [])
    let chartChampionButtonTap = PublishRelay<LookAroundChampionRankAttribute>()

    let interestedList = BehaviorRelay<[LookAroundInterestedGroupAttribute]>(value: [])
    let interestedButtonTap = PublishRelay<LookAroundInterestedGroupAttribute>()

    override init() {
        super.init()
        lifeCycleStatus
            .filter { $0 == .viewDidLoad }
            .take(1)
            .bind(onNext: { [weak self] _ in
                self?.bind()
            })
            .disposed(by: disposeBag)
    }

    func getLayoutStatusList() -> Observable<[LookAroundLayoutStatus]> {
        layoutStatusList
            .asObservable()
    }

    func getTopCategoryList() -> Observable<[LookAroundCategoryAttribute]> {
        topCategoryList
            .asObservable()
    }

    func getTopCategoryPrimitiveList() -> [LookAroundCategoryAttribute] {
        topCategoryList.value
    }

    func updateSelectTopCategoryList(categoryIndex: Int) {
        var list = topCategoryList.value
        for index in 0..<list.count {
            list[index].isSelect = false
        }
        list[categoryIndex].isSelect = true
        topCategoryList.accept(list)
    }

    func getTopCategoryButtonTapWithLayoutPositionIndex() -> Observable<Int> {
        topCategoryButtonTap
            .map { $0.index }
    }

    func getChartChampionList(champioTagCategory: LOLChampionTagCategory) -> Observable<[LookAroundChampionRankAttribute]> {
        chartChampioList
            .map {
                $0.filter {
                    champioTagCategory == $0.championTagCategory
                }
            }
            .map { list in
                return list.count >= 25 ? Array(list[0..<25]) : list
            }
    }

    func getChartChampionPrimitiveList(champioTagCategory: LOLChampionTagCategory?) -> [LookAroundChampionRankAttribute] {
        let filterList = chartChampioList.value
            .filter {
                champioTagCategory == $0.championTagCategory
            }

        return filterList.count >= 25 ? Array(filterList[0..<25]) : filterList
    }

    func getChartChampioButtonTapWithChampionID() -> Observable<String> {
        chartChampionButtonTap
            .map { $0.id }
    }

    func getInterestedGroupList(interestedStatus: LookAroundInterestedStatus) -> Observable<[LookAroundInterestedGroupAttribute]> {
        interestedList
            .map {
                $0.filter {
                    interestedStatus == $0.status
                }
            }
    }

    func getInterestedGroupPrimitiveList(interestedStatus: LookAroundInterestedStatus?) -> [LookAroundInterestedGroupAttribute] {
        interestedList.value
            .filter {
                interestedStatus == $0.status
            }
    }

    func getInterestedGroupButtonTapWithTitle() -> Observable<String> {
        interestedButtonTap
            .map { $0.title }
    }


    func getChartCategoryTitle(chartCategory: LOLChampionTagCategory) -> String? {
        switch chartCategory {
        case .assassin:
            return R.string.localizable.lookAroundChartCategoryAssassinTitle()
        case .fighter:
            return R.string.localizable.lookAroundChartCategoryFighterTitle()
        case .mage:
            return R.string.localizable.lookAroundChartCategoryMageTitle()
        case .marksman:
            return R.string.localizable.lookAroundChartCategoryMarksmanTitle()
        case .support:
            return R.string.localizable.lookAroundChartCategorySupportTitle()
        case .tank:
            return R.string.localizable.lookAroundChartCategoryTankTitle()
        }
    }

    func getInterestedStatusTitle(interestedState: LookAroundInterestedStatus) -> String? {
        switch interestedState {
        case .position:
            return R.string.localizable.lookAroundInterestedStatusPositionTitle()
        case .tier:
            return R.string.localizable.lookAroundInterestedStatusTierTitle()
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

        repository.getChartChampionList()
            .bind(to: chartChampioList)
            .disposed(by: disposeBag)

        repository.getInterestedGroupList()
            .bind(to: interestedList)
            .disposed(by: disposeBag)
    }

    private func bindTopCategoryList() -> Observable<[LookAroundCategoryAttribute]> {
        layoutStatusList
            .map { statusList in
                statusList.enumerated().map { [weak self] index ,status in
                    switch status {
                    case .chart(let lookAroundChartAttribute):
                        return LookAroundCategoryAttribute(
                            index: index,
                            categoryText: self?.getChartCategoryTitle(chartCategory: lookAroundChartAttribute.championTagCategory)
                        )
                    case .interestedGroup(let interestedStatus):
                        return LookAroundCategoryAttribute(
                            index: index,
                            categoryText: self?.getInterestedStatusTitle(interestedState: interestedStatus)
                        )
                    }
                }
            }
    }
}
