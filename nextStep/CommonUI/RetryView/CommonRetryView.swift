//
//  CommonRetryView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonRetryView: UIView {
    private let host: RetryEnabledProtocol?
    private let disposeBag = DisposeBag()
    private lazy var retryView: RetryView? = RetryView(host: host)

    init(frame: CGRect = .zero, host: RetryEnabledProtocol) {
        self.host = host
        super.init(frame: frame)
        attribute()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        retryView?.getRetryButtonTap()
            .bind(onNext: { [weak self] _ in
                self?.host?.processRetry()
                self?.removeFromSuperview()
                self?.retryView = nil
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        alpha = 0.0
        backgroundColor = .white
    }

    func layoutRetryContainerView() {
        guard let superView = host?.retryContainerView else { return }

        superView.addSubview(self)
        guard let retryView = retryView else { return }
        addSubview(retryView)
        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        retryView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        UIView.animate(withDuration: 0.8, animations: { [weak self] in
            self?.alpha = 1
        })
    }

    final class RetryView: UIView {
        private let imageView = UIImageView()
        private let retryButton = UIView()
        private let retryButtonLabel = UILabel()

        override var intrinsicContentSize: CGSize {
            let width: CGFloat = 256
            let imageHeight: CGFloat = 64
            let buttonHeight: CGFloat = 44
            let height = 16 + imageHeight + 16 + buttonHeight + 16

            return CGSize(width: width, height: height)
        }

        init(frame: CGRect = .zero, host: RetryEnabledProtocol?) {
            super.init(frame: frame)
            attribute()
            layout()
            self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func getRetryButtonTap() -> Observable<ControlEvent<UITapGestureRecognizer>.Element> {
            retryButton.rx.tapGesture()
                .when(.recognized)
        }

        private func attribute() {
            imageView.image = UIImage(systemName: "pencil.circle.fill")
            imageView.layer.cornerRadius = 32
            imageView.contentMode = .scaleAspectFill

            retryButton.layer.cornerRadius = 4
            retryButton.backgroundColor = .systemBlue

            retryButtonLabel.font = R.font.notoSansSemiBold(size: 16)
            retryButtonLabel.text = "재시도"
            retryButtonLabel.textColor = .white
        }

        private func layout() {
            [
                imageView,
                retryButton,
                retryButtonLabel,
            ].forEach {
                addSubview($0)
            }
            imageView.snp.makeConstraints {
                $0.size.equalTo(64)
                $0.top.equalToSuperview().inset(16)
                $0.centerX.equalToSuperview()
            }
            retryButton.snp.makeConstraints {
                $0.width.equalTo(256)
                $0.height.equalTo(44)
                $0.top.equalTo(imageView.snp.bottom).offset(16)
                $0.centerX.equalToSuperview()
            }

            retryButtonLabel.snp.makeConstraints {
                $0.center.equalTo(retryButton)
            }
        }
    }
}

