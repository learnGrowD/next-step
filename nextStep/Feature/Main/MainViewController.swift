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

    let testButton = UILabel()

    let depthViewControllerTestButton = UILabel()

    override func bind(_ viewModel: MainViewModel) {
        super.bind(viewModel)

        testButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                CommonModal.Builder()
//                    .setTitle("HELLO")
                    .setMessage("HELLO")
                    .setImage(UIImage(systemName: "pencil"), width: 44, height: 44)
                    .setNagativeButton("부정") {
                        $0.dismiss(animated: true)
                    }
                    .setPositiveButton("긍정") {
                        $0.dismiss(animated: true)
                    }
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)

        depthViewControllerTestButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                print("depthViewController: \(self?.depthViewController)")
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        view.backgroundColor = .white
        testButton.text = "TestButton"
        depthViewControllerTestButton.text = "depthViewControllerTestButton"
    }

    override func layout() {
        super.layout()
        view.addSubview(testButton)
        view.addSubview(depthViewControllerTestButton)
        testButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        depthViewControllerTestButton.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
