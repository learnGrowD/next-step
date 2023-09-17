//
//  SplashViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewController: BaseViewController<BaseViewModel> {
    let testButton = UILabel()


    override func bind(_ viewModel: BaseViewModel) {
        super.bind(viewModel)
        testButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let mainVc = MainViewController(viewModel: MainViewModel())
                self?.navigationController?.pushViewController(mainVc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        testButton.text = "TEST"
    }

    override func layout() {
        super.layout()
        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }
}
