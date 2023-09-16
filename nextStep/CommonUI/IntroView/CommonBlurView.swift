//
//  CommonBlurView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import Lottie
import RxSwift
import RxCocoa
import UIColor_Hex_Swift

final class CommonBlurView: UIView, IntroViewProtocol {
    private var disposeBag: DisposeBag? = DisposeBag()
    private var commonLoadingView: CommonLoadingView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        blockTouch()

        isHidden = false
        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.milliseconds(1300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                if $0 == 0 {
                    self?.commonLoadingView = CommonLoadingView(milliseconds: 0)
                    self?.commonLoadingView?.show()
                }
            })
            .disposed(by: disposeBag)
    }

    func dismiss() {
        allowTouch()

        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                if $0 == 0 {
                    self?.disposeBag = nil
                    self?.commonLoadingView?.dismiss()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.alpha = 0
                    }, completion: { _ in
                        self?.isHidden = true
                    })
                }
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        isHidden = true
        backgroundColor = UIColor("#212121")
    }

    private func layout() {
        let depthViewController = depthViewController
        let superView = depthViewController?.view
        guard let superView = superView else { return }
        superView.addSubview(self)
        snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    private func blockTouch() {
        window?.isUserInteractionEnabled = false
    }

    private func allowTouch() {
        window?.isUserInteractionEnabled = true
    }
}
