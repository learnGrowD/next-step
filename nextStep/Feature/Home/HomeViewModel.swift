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
    let homeLayoutCategoryList = BehaviorRelay<[HomeLayoutCategory]>(value: [
        .banner,
        .top,
        .middle,
        .jungle,
        .bottom,
        .support
    ])

    let homeBannerList = BehaviorRelay<[HomeBannerItemAttribute]>(value: [])
    let homeBannerButtonTap = PublishRelay<HomeBannerItemAttribute>()

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
}
