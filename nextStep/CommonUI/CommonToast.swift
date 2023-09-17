//
//  CommonToast.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import Toast_Swift
import RxSwift
import RxCocoa

enum CommonToastStatus {
    case top
    case center
    case bottom
}

struct CommonToastCreateContext {
    let status: CommonToastStatus
    let message: String
    let onClickDeleage: (CommonToast) -> Void
}

protocol CommonToastProtocol {
    func show()
}

class CommonToast: UIView, CommonToastProtocol {
    private let disposeBag = DisposeBag()
    let messageLabel = UILabel()
    var onClickDelegate: (CommonToast) -> Void = { _ in }

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        bind()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {}

    private func bind() {
        rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.onClickDelegate(self)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func setUI(data: CommonToastCreateContext) {
        self.messageLabel.text = data.message
        self.onClickDelegate = data.onClickDeleage
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    fileprivate func attribute() {
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = .white
    }
    fileprivate func layout() {
        addSubview(messageLabel)
    }

    final class Builder {
        private var status: CommonToastStatus = .bottom
        private var message: String = ""
        private var onClickDelegate: (CommonToast) -> Void = { _ in }

        func setMessage(message: String) -> Self {
            self.message = message
            return self
        }

        func setOnClickDelegate(_ delegate: @escaping (CommonToast) -> Void) -> Self {
            self.onClickDelegate = delegate
            return self
        }

        func build(status: CommonToastStatus) -> CommonToastProtocol {
            let commonToastCreateContext = CommonToastCreateContext(
                status: status,
                message: message,
                onClickDeleage: onClickDelegate
            )
            switch status {
            case .top:
                return TopCommonToast().then {
                    $0.setUI(data: commonToastCreateContext)
                }
            case .center:
                return CenterCommonToast().then {
                    $0.setUI(data: commonToastCreateContext)
                }
            case .bottom:
                return BottomCommonToast().then {
                    $0.setUI(data: commonToastCreateContext)
                }
            }
        }
    }
}

//MARK: - top
private final class TopCommonToast: CommonToast {

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 16 + messageLabel.intrinsicContentSize.height + 16
        return CGSize(width: width, height: height)
    }

    override func show() {
        super.show()
        topMostViewController?.view.showToast(self, duration: 1, position: .top)
    }

    override func attribute() {
        super.attribute()
        backgroundColor = .systemBlue
    }

    override func layout() {
        super.layout()
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

//MARK: - center
private final class CenterCommonToast: CommonToast {
    private let imageView = UIImageView()
    override var intrinsicContentSize: CGSize {
        let width: CGFloat = 256

        let imageHeight: CGFloat = 56
        let messageHeight: CGFloat = messageLabel.intrinsicContentSize.height
        let height = 16 + imageHeight + messageHeight + 16 + 16

        return CGSize(width: width, height: height)
    }
    override func show() {
        super.show()
        topMostViewController?.view.showToast(self, duration: 1, position: .center)
    }

    override func attribute() {
        super.attribute()
        backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 28
        imageView.kf.setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRHIv7WPWnOqjiHtk-2_Vm34hus7ceXLqeh6Cjw0LdoA&s"))
    }
    override func layout() {
        super.layout()
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: - bottom
private final class BottomCommonToast: CommonToast {

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 16 + messageLabel.intrinsicContentSize.height + 16
        return CGSize(width: width, height: height)
    }

    override func show() {
        super.show()
        topMostViewController?.view.showToast(self, duration: 1, position: .bottom)
    }
    override func attribute() {
        super.attribute()
        backgroundColor = .systemRed
    }
    override func layout() {
        super.layout()
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
