//
//  RiotAPI.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import Foundation
import RxSwift
import RxCocoa

struct RiotAPI {
    static let shared = RiotAPI()
    private init() {}
    
    func getChampionList() -> Observable<[RiotChampionResult]> {
        let context = RiotAPIRequestContext(
            path: "/champion.json",
            params: [:],
            requestUIMode: .blur,
            resultUIMode: .showWarning
        )
        let service = CommonRESTfulAPIService<RiotWrapper<[String: RiotChampionResult]>>(requestContext: context)
        return service.getMapping()
            .map {
                var result: [RiotChampionResult] = []
                $0.forEach {
                    result.append($0.value)
                }
                return result
            }
    }
}
