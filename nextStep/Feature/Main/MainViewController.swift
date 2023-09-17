//
//  MainViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController<MainViewModel>, RetryEnabledProtocol {
    var retryContainerView: UIView {
        view
    }

    func processRetry() {
        print("HELLo")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let requestContext = RiotAPIRequestContext(path: "/champion.jso", params: [:], requestUIMode: .blur, resultUIMode: .showToast)
        let api = CommonRESTfulAPIService<RiotWrapper<[String: Champion]>>(requestContext: requestContext)
        api.getMapping()
            .catchAndReturn(["dd": Champion(id: "", title: "")])
            .bind(onNext: {
                print("HELLO: \($0)")
            })
            .disposed(by: disposeBag)
    }
    override func attribute() {
        super.attribute()
        view.backgroundColor = .white
    }
}


struct Champion: Codable {
    let id: String
    let title: String
}
