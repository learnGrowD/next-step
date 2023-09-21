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
//        .top,
//        .middle,
//        .jungle,
//        .bottom,
//        .support
    ])

    let homeBannerList = BehaviorRelay<[HomeBannerItemAttribute]>(value: [
        .init(id: 0, backgroundImageURL: "", categoryText: "wef", title: "wef", allCount: 0, date: Date(), skinImageURLList: [], championInformation: "qrr"),
        .init(id: 0, backgroundImageURL: "", categoryText: "wef", title: "wef", allCount: 0, date: Date(), skinImageURLList: [], championInformation: "qrr"),
    ])
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
