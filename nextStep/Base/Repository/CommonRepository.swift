//
//  CommonRepository.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit

protocol CommonRepositoryProtocol {}
extension CommonRepositoryProtocol {
    var riotAPI: RiotAPI { RiotAPI.shared }

    func getTierRandomUIImage() -> UIImage? {
        let randomElement = [
            R.image.tierIron(),
            R.image.tierBronze(),
            R.image.tierSilver(),
            R.image.tierGold(),
            R.image.tierPlatinum(),
            R.image.tierDiamond(),
            R.image.tierGrandmaster(),
            R.image.tierMaster(),
            R.image.tierChallenger(),
        ].randomElement()
        guard let randomElement = randomElement else { return R.image.tierChallenger() }
        return randomElement
    }

    func getPositionRandomUIImage() -> UIImage? {
        let randomElement = [
            R.image.positionTop(),
            R.image.positionJungle(),
            R.image.positionMiddle(),
            R.image.positionBottom(),
            R.image.positionSupport(),
        ].randomElement()
        guard let randomElement = randomElement else { return R.image.tierChallenger() }
        return randomElement
    }
}
