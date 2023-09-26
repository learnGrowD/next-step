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
            .map { championDictionary in
                var result: [RiotChampionResult] = []
                championDictionary.forEach { champion in
                    result.append(champion.value)
                }
                return result
            }
    }

    func getChampionDtail(championID: String) -> Observable<RiotChampionDetailResult?> {
        let context = RiotAPIRequestContext(
            path: "/champion/\(championID).json",
            params: [:],
            requestUIMode: .blur,
            resultUIMode: .showWarning
        )
        let service = CommonRESTfulAPIService<RiotWrapper<[String: RiotChampionDetailResult]>>(requestContext: context)
        return service.getMapping()
            .map { championDictionary in
                championDictionary[championID]
            }
    }
}
