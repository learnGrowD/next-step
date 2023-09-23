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
    let homeLayoutCategoryList = BehaviorRelay<[HomeLayoutCategory]>(value: [])
    let homeBannerList = BehaviorRelay<[HomeBannerItemAttribute]>(value: [])
    let homeBannerButtonTap = PublishRelay<HomeBannerItemAttribute>()
    let categoryList = BehaviorRelay<[HomeChampionCategoryAttribute]>(value: [])
    let categoryButtonTap = PublishRelay<HomeChampionCategoryAttribute>()

    override init() {
        super.init()
        bind()
    }

    func getTitle(category: LOLChampionTagCategory) -> String {
        switch category {
        case .assassin:
            return "어썌신"
        case .fighter:
            return "파이터"
        case .mage:
            return "메이지"
        case .marksman:
            return "마크맨"
        case .support:
            return "서포터"
        case .tank:
            return "탱커"
        }

    }

    func getHomeLayoutCategoryList() -> Observable<[HomeLayoutCategory]> {
        homeLayoutCategoryList
            .filter { !$0.isEmpty }
            .asObservable()
    }

    func getHomeBannerList() -> Observable<[HomeBannerItemAttribute]> {
        homeBannerList
            .filter { !$0.isEmpty }
            .asObservable()
    }

    func getCategoryList(category: LOLChampionTagCategory) -> Observable<[HomeChampionCategoryAttribute]> {
        categoryList
            .filter { !$0.isEmpty }
            .map {
                $0.filter {
                    category == $0.category
                }
            }
            .asObservable()
    }

    private func bind(_ repository: HomeRepository = HomeRepository.shared) {
        repository.getLayouts()
            .take(1)
            .bind(to: homeLayoutCategoryList)
            .disposed(by: disposeBag)

        repository.getCategory()
            .take(1)
            .bind(to: categoryList)
            .disposed(by: disposeBag)
    }
}
