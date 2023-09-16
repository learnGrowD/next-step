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
        api.getMapping()
            .catch {
                print($0.localizedDescription)
                return Observable<[String: Champion]>.empty()
            }
            .bind(onNext: {

                print($0)
            })
            .disposed(by: disposeBag)
    }
}

struct Champion: Codable {
    let id: String
    let title: String
}
