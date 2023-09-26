//
//  GalleryViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import PanModal

final class GalleryViewController: BaseViewController<GalleryViewModel>, BasePanModalPresentable {
    private let headerLabel = UILabel()
    var shortFormHeight: PanModalHeight { .contentHeight(516) }
    var longFormHeight: PanModalHeight { .contentHeight(516) }

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        headerLabel.text = "갤러리"
    }

    override func layout() {
        super.layout()
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
