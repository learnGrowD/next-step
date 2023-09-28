//
//  SkillDetailViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/28.
//

import UIKit
import RxSwift
import RxCocoa

final class SkillDetailViewController: BaseViewController<SkillDetailViewModel>, BasePanModalPresentable {
    private let titleLabel = UILabel()
    private let avPlayerContainer = UIView()
    private let skillImageView = UIImageView()
    private let skillKeyLabel = UILabel()
    private let skillNameLabel = UILabel()
    private let skillDescriptionLabel = UILabel()

    override func attribute() {
        super.attribute()
        titleLabel.font = .nestStepRegular(size: .small)

        avPlayerContainer.backgroundColor = .systemBlue
        skillNameLabel.font = .nestStepRegular(size: .medium)

        skillKeyLabel.layer.cornerRadius = 12
        skillKeyLabel.clipsToBounds = true
        skillKeyLabel.backgroundColor = R.color.nestStepLightBlack()
        skillKeyLabel.font = .nestStepBold(size: .medium)
        skillKeyLabel.textColor = R.color.nestStepBrand()
        skillKeyLabel.textAlignment = .center

        skillDescriptionLabel.font = .nestStepRegular(size: .small)
        skillDescriptionLabel.numberOfLines = 0
    }

    override func layout() {
        super.layout()
        view.addSubViews(titleLabel, avPlayerContainer, skillImageView, skillKeyLabel, skillNameLabel, skillDescriptionLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        avPlayerContainer.snp.makeConstraints {
            $0.height.equalTo(216)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        skillImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalTo(avPlayerContainer.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
        }
        skillKeyLabel.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.bottom.trailing.equalTo(skillImageView)
        }
        skillNameLabel.snp.makeConstraints {
            $0.leading.equalTo(skillImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(skillImageView)
        }
        skillDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(skillImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }

    override func bind(_ viewModel: SkillDetailViewModel) {
        super.bind(viewModel)
        viewModel.getSkillTitle()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
