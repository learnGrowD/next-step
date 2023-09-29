//
//  GalleryViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import PanModal

final class GalleryViewController: BaseViewController<GalleryViewModel> {
    private let titleNavigationLabel = UILabel()

    private let profileImageView = UIImageView()

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        titleNavigationLabel.font = .nestStepBold(size: .large)
        titleNavigationLabel.text = R.string.localizable.galleryTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleNavigationLabel)

    }

    override func layout() {
        super.layout()
    }
}
