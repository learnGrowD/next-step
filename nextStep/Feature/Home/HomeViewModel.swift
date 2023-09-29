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
    let homeLayoutStatusList = BehaviorRelay<[HomeLayoutStatus]>(value: [])
    let homeBannerList = BehaviorRelay<[HomeBannerItemAttribute]>(value: [])
    let homeBannerButtonTap = PublishRelay<HomeBannerItemAttribute>()

    let categoryList = BehaviorRelay<[HomeChampionCategoryAttribute]>(value: [])
    let categoryButtonTap = PublishRelay<HomeChampionCategoryAttribute>()

    let betweenBannerButtonTap = PublishRelay<HomeBetweenBannerAttribute?>()

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

    func getTitle(category: LOLChampionTagCategory?) -> String {
        switch category {
        case .assassin:
            return R.string.localizable.homeAssassin()
        case .fighter:
            return R.string.localizable.homeFighter()
        case .mage:
            return R.string.localizable.homeMage()
        case .marksman:
            return R.string.localizable.homeMarksman()
        case .support:
            return R.string.localizable.homeSupport()
        case .tank:
            return R.string.localizable.homeTank()
        default: return ""
        }

    }

    func gethomeLayoutStatusList() -> Observable<[HomeLayoutStatus]> {
        homeLayoutStatusList
            .asObservable()
    }

    func getHomeBannerList() -> Observable<[HomeBannerItemAttribute]> {
        homeBannerList
            .asObservable()
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
            .bind(to: homeLayoutStatusList)
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
