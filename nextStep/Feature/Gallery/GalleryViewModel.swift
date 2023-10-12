//
//  GalleryViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleryViewModel: BaseViewModel {
    let list = BehaviorRelay<[GalleryInformationAttribute]>(value: [])
    let informationButtonTap = PublishRelay<GalleryInformationAttribute>()

    override init() {
        super.init()
        bind()
    }


    func getGalleyInformationList() -> Observable<[GalleryInformationAttribute]> {
        list
            .filter { !$0.isEmpty }
    }

    func getInformationButtonTapWithAttributeData() -> Observable<GalleryInformationAttribute> {
        informationButtonTap
            .asObservable()
    }

    private func bind(_ repository: GalleyRepository = GalleyRepository()) {
        repository.getInformationList()
            .take(1)
            .bind(to: list)
            .disposed(by: disposeBag)
    }
}
