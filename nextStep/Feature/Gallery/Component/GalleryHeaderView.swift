//
//  GalleryHeaderView.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import UIKit

final class GalleryHeaderView: UIView {
    private let viewModel: GalleryViewModel
    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    init(frame: CGRect = .zero, viewModel: GalleryViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {

        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = NestStepCornerRadiusCategory.middle.rawValue
        profileImageView.image = UIImage(named: "will_d")

        nickNameLabel.font = .nestStepRegular(size: .medium)
        nickNameLabel.text = "will_d"
    }

    private func layout() {
        addSubViews(profileImageView, nickNameLabel)
        let height: CGFloat = 16 + 124 + 16 + nickNameLabel.intrinsicContentSize.height + 32
        frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: height
        )
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(124)
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}
