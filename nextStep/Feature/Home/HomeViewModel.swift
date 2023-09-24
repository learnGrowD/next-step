//
//  HomeViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {
    private let HomeLayoutStatusList = BehaviorRelay<[HomeLayoutStatus]>(value: [])
    private let homeBannerList = BehaviorRelay<[HomeBannerItemAttribute]>(value: [])
    let homeBannerButtonTap = PublishRelay<HomeBannerItemAttribute>()

    private let categoryList = BehaviorRelay<[HomeChampionCategoryAttribute]>(value: [])
    let categoryButtonTap = PublishRelay<HomeChampionCategoryAttribute>()

    let betweenBannerButtonTap = PublishRelay<HomeBetweenBannerAttribute?>()

    override init() {
        super.init()
        bind()
    }

    func getTitle(category: LOLChampionTagCategory?) -> String {
        switch category {
        case .assassin:
            return R.string.localizable.homeViewModelAssassin()
        case .fighter:
            return R.string.localizable.homeViewModelFighter()
        case .mage:
            return R.string.localizable.homeViewModelMage()
        case .marksman:
            return R.string.localizable.homeViewModelMarksman()
        case .support:
            return R.string.localizable.homeViewModelSupport()
        case .tank:
            return R.string.localizable.homeViewModelTank()
        default: return ""
        }

    }

    func getHomeLayoutStatusList() -> Observable<[HomeLayoutStatus]> {
        HomeLayoutStatusList
            .filter { !$0.isEmpty }
    }

    func getHomeBannerList() -> Observable<[HomeBannerItemAttribute]> {
        homeBannerList
            .filter { !$0.isEmpty }
    }

    func getHomeBannerPrimitiveList() -> [HomeBannerItemAttribute] {
        homeBannerList.value
    }

    func getHomeBannerButtonTapWithChampionID() -> Observable<String> {
        homeBannerButtonTap
            .map { $0.id }
            .asObservable()
    }

    func getCategoryList(category: LOLChampionTagCategory?) -> Observable<[HomeChampionCategoryAttribute]> {
        categoryList
            .filter { !$0.isEmpty }
            .map {
                $0.filter {
                    category == $0.category
                }
            }
    }

    func getCategoryPrimitiveList(category: LOLChampionTagCategory?) -> [HomeChampionCategoryAttribute] {
        categoryList.value
            .filter {
                category == $0.category
            }
    }

    func getCategoryButtonTapWithChampionID() -> Observable<String> {
        categoryButtonTap
            .map { $0.id }
            .asObservable()
    }

    func getBetweenBannerButtonTapWithWebURL() -> Observable<String?> {
        betweenBannerButtonTap
            .map { $0?.webURL }
            .asObservable()
    }

    private func bind(_ repository: HomeRepository = HomeRepository()) {
        repository.getLayouts()
            .take(1)
            .bind(to: HomeLayoutStatusList)
            .disposed(by: disposeBag)

        repository.getBannerList()
            .take(1)
            .bind(to: homeBannerList)
            .disposed(by: disposeBag)

        repository.getCategory()
            .take(1)
            .bind(to: categoryList)
            .disposed(by: disposeBag)
    }
}
