//
//  TestViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/02.
//

import UIKit
import RxSwift
import RxCocoa

class TestViewController: UIViewController {
    let disposeBag = DisposeBag()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        label.text = "안녕"

        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        label.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.label.text = "명중"
            })
            .disposed(by: disposeBag)
    }



}
