//
//  SkillDetailViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/28.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

final class SkillDetailViewController: BaseViewController<SkillDetailViewModel>, BasePanModalPresentable {
    var shortFormHeight: PanModalHeight { .contentHeight(624) }
    var longFormHeight: PanModalHeight { .contentHeight(624) }
    private let titleLabel = UILabel()
    private let avPlayerContainer = UIView()
    private let skillImageView = UIImageView()
    private let skillKeyLabel = UILabel()
    private let skillNameLabel = UILabel()
    private let skillDescriptionLabel = UILabel()

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        titleLabel.font = .nestStepRegular(size: .small)

        avPlayerContainer.backgroundColor = .systemBlue
        avPlayerContainer.clipsToBounds = true
        avPlayerContainer.layer.cornerRadius = NestStepCornerRadiusCategory.middle.rawValue

        skillImageView.clipsToBounds = true
        skillImageView.layer.cornerRadius = NestStepCornerRadiusCategory.small.rawValue

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
            let height = "A".getRegularHeightSize(size: .small, width: 100, numberOfLines: 1)
            $0.height.equalTo(height)
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        avPlayerContainer.snp.makeConstraints {
            $0.height.equalTo(216)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        skillImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalTo(avPlayerContainer.snp.bottom).offset(24)
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
        }
    }

    override func bind(_ viewModel: SkillDetailViewModel) {
        super.bind(viewModel)
        viewModel.getSkillTitle()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.getSkillImageURL()
            .bind(to: skillImageView.rx.imageURLString)
            .disposed(by: disposeBag)

        viewModel.getSkillKey()
            .bind(to: skillKeyLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.getSkillName()
            .bind(to: skillNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.getSkillDescription()
            .bind(to: skillDescriptionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.getSkillName()
            .bind(to: skillNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
