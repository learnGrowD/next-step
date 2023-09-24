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
    let categoryList = BehaviorRelay<[LookAroundCategoryAttribute]>(value: [
        LookAroundCategoryAttribute(
            categoryStatus: .chart,
            categoryText: "차트",
            isSelect: false
        ),
        LookAroundCategoryAttribute(
            categoryStatus: .tier,
            categoryText: "티어",
            isSelect: false
        ),
        LookAroundCategoryAttribute(
            categoryStatus: .position,
            categoryText: "포지션",
            isSelect: false
        )
    ])
    let categoryButtonTap = PublishRelay<LookAroundCategoryAttribute>()

    func getCategoryList() -> Observable<[LookAroundCategoryAttribute]> {
        categoryList
            .filter { !$0.isEmpty }
    }

    func getCategoryButtonTapWithCategoryStatus() -> Observable<LookAroundCategoryStatus> {
        categoryButtonTap
            .map { $0.categoryStatus }
            .asObservable()
    }
}
