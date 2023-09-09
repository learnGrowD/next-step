//
//  MainViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController<MainViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestContext = RiotAPIRequestContext(path: "/champion.json", params: [:], requestUIMode: .blur, resultUIMode: .login)
        let api = CommonAPIService<RiotWrapper<[String: Champion]>>(requestContext: requestContext)

        api.request(method: .get).map {
            $0.count
        }
        .catchAndReturn(10)
        .bind(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    }

    func aaa() throws -> Int {
        return 10
    }


}
struct Champion: Codable {
    let id: String
}

enum InputError: Error {
    case nonPositiveNumber
}
