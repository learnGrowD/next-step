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
                let action1 = CommonBottomModalActionContext(titleString: "HELLO", titleColorString: "#00CED1") {
                    $0.dismiss(animated: true)
                }
                let action2 = CommonBottomModalActionContext(titleString: "HELLO", titleColorString: "#BA55D3") {
                    $0.dismiss(animated: true)
                }
                let action3 = CommonBottomModalActionContext(titleString: "HELLO", titleColorString: "#FF69B4") {
                    $0.dismiss(animated: true)
                }
                let action4 = CommonBottomModalActionContext(titleString: "HELLO", titleColorString: "#32CD32") {
                    $0.dismiss(animated: true)
                }
                let action5 = CommonBottomModalActionContext(titleString: "HELLO", titleColorString: "#87CEEB") {
                    $0.dismiss(animated: true)
                }
                CommonBottomModal.Builder()
                    .setActions([action1, action2, action3, action4, action5])
                    .setActionBackgroundColor(.systemRed)
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
