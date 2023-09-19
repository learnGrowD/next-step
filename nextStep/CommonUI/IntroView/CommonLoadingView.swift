//
//  CommonLoadingView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import Foundation
import Lottie
import RxSwift
import RxCocoa

final class CommonLoadingView: IntroViewProtocol, AppStorageProtocol {
    private var disposeBag: DisposeBag? = DisposeBag()
    private var loadingView: LottieAnimationView? = LottieAnimationView(name: LottieResourceManager.defaultLoadingName)
    private var milliseconds = 800

    init(milliseconds: Int = 800) {
        self.milliseconds = milliseconds
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        blockTouch()

        loadingView?.isHidden = true
        UIView.animate(withDuration: 0.8, animations: { [weak self] in
            self?.loadingView?.alpha = 1
        })

        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.milliseconds(milliseconds), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 == 0 {
                    self.loadingView?.isHidden = false
                    self.loadingView?.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
                    self.disposeBag = nil
                }
            })
            .disposed(by: disposeBag)
    }

    func dismiss() {
        allowTouch()

        disposeBag = nil

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.loadingView?.alpha = 0
        }, completion: { [weak self] _ in
            self?.loadingView?.isHidden = true
            self?.loadingView?.stop()
            self?.loadingView?.removeFromSuperview()
            self?.loadingView = nil
        })
    }

    private func attribute() {
        loadingView?.alpha = 0
        loadingView?.isHidden = true
        loadingView?.contentMode = .scaleAspectFill
        loadingView?.loopMode = .loop
        loadingView?.play()
    }

    private func layout() {
        let superView = topMostViewController?.view
        guard let loadingView = loadingView,
              let superView = superView else { return }
        superView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.size.equalTo(164)
            $0.center.equalToSuperview()
        }
    }

    private func blockTouch() {
        window?.isUserInteractionEnabled = false
    }

    private func allowTouch() {
        window?.isUserInteractionEnabled = true
    }
}
