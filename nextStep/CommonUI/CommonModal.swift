//
//  CommonModal.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import RxSwift
import RxCocoa
import Then
/*
 이런식으로 쓰면 됌.
 WilldModal.Builder()
     .setTitle("알림")
     .setMessage("확인")
     .setPositiveButton("긍정") {
         print("긍정")
     }
     .setNagativeButton("부정") {
         print("부정")
     }
     .build()
     .show()
 */

final class CommonModal: BaseViewController<BaseViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private var titleLabel: UILabel?
    private var imageView: UIImageView?
    private let messageLabel = UILabel()
    private let underlineView = UIView()
    private let nagativeButton = UILabel()
    private var nagativeDelegate: (CommonModal) -> Void = { _ in }
    private let positiveButton = UILabel()
    private var positiveDelegate: (CommonModal) -> Void = { _ in }
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [nagativeButton, positiveButton])
    private let pillarlineView = UIView()

    func show() {
        if topMostViewController !== self {
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .overFullScreen
            topMostViewController?.present(self, animated: true)
        }
    }

    override func bind(_ viewModel: BaseViewModel) {
        super.bind(viewModel)

        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        nagativeButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.nagativeDelegate(self)
            })
            .disposed(by: disposeBag)

        positiveButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.positiveDelegate(self)
            })
            .disposed(by: disposeBag)
    }

    private func configure(
        title: String,
        message: String,

        image: UIImage?,
        imageUrl: String?,
        imgWidth: CGFloat,
        imgHeight: CGFloat,

        nagativeButtonStr: String,
        nagativeButtonDelegate: @escaping (CommonModal) -> Void,
        positiveButtonStr: String,
        positiveButtonDelegate: @escaping (CommonModal) -> Void,

        /*
         속성
         */
        titleColor: UIColor,
        messageColor: UIColor,
        nagativeButtonColor: UIColor,
        positiveButtonColor: UIColor,
        modalBackgroundColor: UIColor,
        lineColor: UIColor,
        /*
         설정
         */
        titleFont: UIFont?,
        messageFont: UIFont?,
        buttonFont: UIFont?
    ) {
        let isImageNotExist = (imageUrl?.isEmpty == true) || image == nil
        self.layout(title: title, isImageNotExist: isImageNotExist, imageWidth: imgWidth, imageHeight: imgHeight)

        self.messageLabel.text = message


        //title 0, iamge 0, message 0,
        if !title.isEmpty && !isImageNotExist {
            self.titleLabel?.text = title
            self.setImage(image: image, imageURL: imageUrl)
        }

        //title 0, image x, message 0,
        if !title.isEmpty && isImageNotExist {
            self.titleLabel?.text = title
        }

        //title x, image 0, message 0,
        if title.isEmpty && !isImageNotExist {
            self.setImage(image: image, imageURL: imageUrl)
        }

        //title x, image x, messag 0
        if title.isEmpty && isImageNotExist {}

        /*
         setNavigationButton을 안한다면 숨겨서 positiveButton만 보이게 동작하자...
         */
        self.nagativeButton.isHidden = nagativeButtonStr.isEmpty
        self.pillarlineView.isHidden = nagativeButtonStr.isEmpty

        self.nagativeButton.text = nagativeButtonStr
        self.nagativeDelegate = nagativeButtonDelegate

        self.positiveButton.text = positiveButtonStr
        self.positiveDelegate = positiveButtonDelegate

        /*
        속성
        */
        self.titleLabel?.textColor = titleColor
        self.messageLabel.textColor = messageColor
        self.nagativeButton.textColor = nagativeButtonColor
        self.positiveButton.textColor = positiveButtonColor
        self.containerView.backgroundColor = modalBackgroundColor
        self.underlineView.backgroundColor = lineColor
        self.pillarlineView.backgroundColor = lineColor
        /*
         설정
         */
        self.titleLabel?.font = titleFont
        self.messageLabel.font = messageFont
        self.nagativeButton.font = buttonFont
        self.positiveButton.font = buttonFont
    }

    private func setImage(image: UIImage?, imageURL: String?) {
        if let image = image {
            imageView?.image = image
        }

        if let imageURL = imageURL {
            imageView?.kf.setImage(with: URL(string: imageURL))
        }
    }

    override func attribute() {
        super.attribute()
        view.backgroundColor = .clear

        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .white

        messageLabel.numberOfLines = 4
        messageLabel.textAlignment = .center

        underlineView.backgroundColor = .systemGray3

        nagativeButton.textAlignment = .center
        positiveButton.textAlignment = .center

        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal

        pillarlineView.backgroundColor = .systemGray3
    }

    private func layout(title: String, isImageNotExist: Bool, imageWidth: CGFloat, imageHeight: CGFloat) {
        view.addSubViews(
            backgroundView,
            containerView,
            messageLabel,
            underlineView,
            buttonStackView,
            pillarlineView
        )

        if !title.isEmpty {
            titleLabel = UILabel()
            titleLabel?.numberOfLines = 1
            titleLabel?.textAlignment = .center
            guard let titleLabel = titleLabel else { return }
            view.addSubview(titleLabel)
        }
        if !isImageNotExist {
            imageView = UIImageView()
            imageView?.contentMode = .scaleAspectFill
            guard let imageView = imageView else { return }
            view.addSubview(imageView)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        //title 0, iamge 0, message 0,
        if !title.isEmpty && !isImageNotExist {
            guard let titleLabel = titleLabel,
                  let imageView = imageView else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(titleLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
            imageView.snp.makeConstraints {
                $0.width.equalTo(imageWidth)
                $0.height.equalTo(imageHeight)
                $0.top.equalTo(titleLabel.snp.bottom).offset(16)
                $0.centerX.equalTo(containerView)
            }
            messageLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        //title 0, image x, message 0,
        if !title.isEmpty && isImageNotExist {
            guard let titleLabel = titleLabel else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(titleLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            titleLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        //title x, image 0, message 0,
        if title.isEmpty && !isImageNotExist {
            guard let imageView = imageView else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(imageView).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            imageView.snp.makeConstraints {
                $0.width.equalTo(imageWidth)
                $0.height.equalTo(imageHeight)
                $0.top.equalTo(containerView)
                $0.centerX.equalTo(containerView).inset(16)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        //title x, image x, messag 0
        if title.isEmpty && isImageNotExist  {
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(messageLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(containerView)
        }
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(underlineView.snp.bottom)
            $0.leading.trailing.equalTo(containerView)
            $0.bottom.equalTo(containerView)
        }
        pillarlineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalTo(buttonStackView)
            $0.centerX.equalTo(buttonStackView)
        }
    }

    final class Builder {
        private var title: String = ""
        private var message: String = ""

        private var image: UIImage?
        private var imageUrl: String?
        private var imageWidth: CGFloat = 0.0
        private var imageHeight: CGFloat = 0.0

        private var nagativeButtonStr: String = ""
        private var nagativeButtonDelegate: (CommonModal) -> Void = { _ in }
        private var positiveButtonStr: String = ""
        private var positiveButtonDelegate: (CommonModal) -> Void = { _ in }

        /*
         color 속성
         */
        private var titleColor: UIColor = .white
        private var messageColor: UIColor = .white
        private var nagativeButtonColor: UIColor = .white
        private var positiveButtonColor: UIColor = .systemBlue
        private var modalBackgroindColor: UIColor = .black
        private var lineColor: UIColor = .systemGray3

        /*
         글자 크기 속성
         */
        private var titleFont: UIFont? = R.font.notoSansSemiBold(size: 20)
        private var messageFont: UIFont? = R.font.notoSansRegular(size: 14)
        private var buttonFont: UIFont? = R.font.notoSansRegular(size: 16)

        func setTitle(_ title: String) -> Self {
            self.title = title
            return self
        }

        func setMessage(_ message: String) -> Self {
            self.message = message
            return self
        }

        func setMessageColor(_ color: UIColor) -> Self {
            self.messageColor = color
            return self
        }

        func setImage(_ image: UIImage?, width: CGFloat, height: CGFloat) -> Self {
            self.image = image
            self.imageWidth = width
            self.imageHeight = height
            return self
        }

        func setImageUrl(_ url: String?, width: CGFloat, height: CGFloat) -> Self {
            self.imageUrl = url
            self.imageWidth = width
            self.imageHeight = height
            return self
        }

        func setNagativeButton(
            _ label: String,
            _ delegate: @escaping (CommonModal) -> Void
        ) -> Self {
            self.nagativeButtonStr = label
            self.nagativeButtonDelegate = delegate
            return self
        }

        func setPositiveButton(
            _ label: String,
            _ delegate: @escaping (CommonModal) -> Void
        ) -> Self {
            self.positiveButtonStr = label
            self.positiveButtonDelegate = delegate
            return self
        }

        /*
         color 속성
         */
        func setTitleColor(_ color: UIColor) -> Self {
            self.titleColor = color
            return self
        }

        func messageColor(_ color: UIColor) -> Self {
            self.messageColor = color
            return self
        }

        func setNagativeButtonColor(_ color: UIColor) -> Self {
            self.nagativeButtonColor = color
            return self
        }

        func setPositiveButtonColor(_ color: UIColor) -> Self {
            self.positiveButtonColor = color
            return self
        }

        func setModalBackgroundColor(_ color: UIColor) -> Self {
            self.modalBackgroindColor = color
            return self
        }

        func setLineColor(_ color: UIColor) -> Self {
            self.lineColor = color
            return self
        }

        /*
         글자 크기 속성
         */
        func setTitleFont(_ font: UIFont?) -> Self {
            self.titleFont = font
            return self
        }

        func setMessageFont(_ font: UIFont?) -> Self {
            self.messageFont = font
            return self
        }

        func setButtonFont(_ font: UIFont?) -> Self {
            self.buttonFont = font
            return self
        }

        func build() -> CommonModal {
            CommonModal(viewModel: BaseViewModel()).then {
                $0.configure(
                    title: title,
                    message: message,
                    image: image,
                    imageUrl: imageUrl,
                    imgWidth: imageWidth,
                    imgHeight: imageHeight,
                    nagativeButtonStr: nagativeButtonStr,
                    nagativeButtonDelegate: nagativeButtonDelegate,
                    positiveButtonStr: positiveButtonStr,
                    positiveButtonDelegate: positiveButtonDelegate,
                    titleColor: titleColor,
                    messageColor: messageColor,
                    nagativeButtonColor: nagativeButtonColor,
                    positiveButtonColor: positiveButtonColor,
                    modalBackgroundColor: modalBackgroindColor,
                    lineColor: lineColor,
                    titleFont: titleFont,
                    messageFont: messageFont,
                    buttonFont: buttonFont
                )
            }
        }
    }
}
