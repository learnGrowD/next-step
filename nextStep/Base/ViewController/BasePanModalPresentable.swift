//
//  BasePanModalPresentable.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa
import RxGesture

protocol BasePanModalPresentable: PanModalPresentable {}

extension BasePanModalPresentable {
    var showDragIndicator: Bool {
        return false
    }

    var springDamping: CGFloat {
        return 1.0
    }

    var topOffset: CGFloat {
        return 0.0
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeight
    }

    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    var anchorModalToLongForm: Bool {
        return false
    }
}

extension BasePanModalPresentable where Self: BaseViewController<BaseViewModel> {
    var containerView: UIView {
        let containerView = UIView()
        view.addSubview(containerView)
        return containerView
    }

    func bindDismiss() {
        view.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)
    }

    func layoutDynamicHegint(topView: UIView) {
        containerView.snp.makeConstraints {
            $0.top.equalTo(topView).inset(-16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
