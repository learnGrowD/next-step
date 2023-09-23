//
//  CommonRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import Foundation

protocol CommonRepositoryProtocol {}
extension CommonRepositoryProtocol {
    var riotAPI: RiotAPI { RiotAPI.shared }
}
