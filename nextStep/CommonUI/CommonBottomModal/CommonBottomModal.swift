//
//  CommonBottomModal.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonBottomModal: BaseViewController<BaseViewModel>, BasePanModalPresentable {
    private var actions: [CommonBottomModalActionContext] = []
    private let actionStackView = UIStackView()
    private let cancelButton = UILabel()

    func show() {
        if topMostViewController !== self {
            topMostViewController?.presentPanModal(self)
        }
    }

    override func bind(_ viewModel: BaseViewModel) {
        super.bind(viewModel)

        Observable.merge(cancelButton.rx.tapGesture().when(.recognized), view.rx.tapGesture().when(.recognized))
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)
    }

    private func configure(
        _ actions: [CommonBottomModalActionContext],
        _ actionFont: UIFont?,
        _ actionBackgroundColor: UIColor,
        _ cancelMessage: String,
        _ cancelFont: UIFont?,
        _ cancelBackgroundColor: UIColor
    ) {
        let labels = actions
            .map { [weak self] in
                guard let self = self else { return UILabel() }
                let actionView = UILabel()
                self.actionDefaultButtonAttribute(label: actionView)
                actionView.text = $0.titleString
                actionView.font = actionFont
                actionView.textColor = UIColor($0.titleColorString)
                actionView.backgroundColor = actionBackgroundColor
                actionView.snp.makeConstraints {
                    $0.height.equalTo(56)
                }
                return actionView
            }
        cancelButton.text = cancelMessage

        labels.forEach {
            actionStackView.addArrangedSubview($0)
        }
        actionStackView.addArrangedSubview(cancelButton)

        view.addSubview(actionStackView)

        actionStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(36)
            $0.top.equalTo(labels[safe: 0] ?? UIView())
        }

        labels
            .enumerated()
            .forEach { index, label in
                label.rx.tapGesture()
                .when(.recognized)
                .bind(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        guard let safeAction = actions[safe: index] else { return }
                        safeAction.action(self)
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    private func actionDefaultButtonAttribute(label: UILabel) {
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
    }

    override func attribute() {
        super.attribute()



        actionStackView.spacing = 8
        actionStackView.axis = .vertical

        actionDefaultButtonAttribute(label: cancelButton)
        cancelButton.font = R.font.notoSansRegular(size: 20)
        cancelButton.textColor = .white
        cancelButton.backgroundColor = .systemBlue

    }

    override func layout() {
        super.layout()
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }

    final class Builder {
        private var actions: [CommonBottomModalActionContext] = []
        private var actionFont: UIFont? = R.font.notoSansRegular(size: 20)
        private var actionBackground: UIColor = .white
        private var cancelMessage: String = "취소"
        private var cancelFont: UIFont? = R.font.notoSansRegular(size: 20)
        private var cancelBackgroundColor: UIColor = .white

        func setActions(_ actions: [CommonBottomModalActionContext]) -> Self {
            self.actions = actions
            return self
        }

        func setActionFont(_ font: UIFont?) -> Self {
            self.actionFont = font
            return self
        }

        func setActionBackgroundColor(_ color: UIColor) -> Self {
            self.actionBackground = color
            return self
        }

        func setCancelMessage(_ message: String) -> Self {
            self.cancelMessage = message
            return self
        }

        func setCancelFont(_ font: UIFont?) -> Self {
            self.cancelFont = font
            return self
        }

        func cancelBackgroundColor(_ color: UIColor) -> Self {
            self.cancelBackgroundColor = color
            return self
        }

        func build() -> CommonBottomModal {
            CommonBottomModal(viewModel: BaseViewModel()).then {
                $0.configure(
                    actions,
                    actionFont,
                    actionBackground,
                    cancelMessage,
                    cancelFont,
                    cancelBackgroundColor
                )
            }
        }

    }
}
