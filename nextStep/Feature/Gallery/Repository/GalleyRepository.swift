//
//  GalleyRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleyRepository: CommonRepositoryProtocol {
    func getInformationList() -> Observable<[GalleryInformationAttribute]> {
        Observable<[GalleryInformationAttribute]>.just(GalleryInformationAttribute.getMockUpData())
    }
}
