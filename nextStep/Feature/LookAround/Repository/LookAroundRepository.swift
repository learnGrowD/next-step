//
//  LookAroundRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import Foundation
import RxSwift
import RxCocoa

class LookAroundRepository: CommonRepositoryProtocol {
    func getLayoutList() -> Observable<[LookAroundLayoutStatus]> {
        Observable.just([
            .chart(championTagCategory: .assassin),
            .chart(championTagCategory: .tank),
            .chart(championTagCategory: .support),
            .interestedGroup(interestedStatus: .tier),
            .interestedGroup(interestedStatus: .position),
        ])
    }

    

    
}
