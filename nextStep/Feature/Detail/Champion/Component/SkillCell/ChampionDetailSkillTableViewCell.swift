//
//  ChampionDetailSkillCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/27.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailSkillCollectionViewCell: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let skillImageView = UIImageView()
    private let skillKeyLabel = UILabel()
    private let skillNameLabel = UILabel()
    private let skillDescriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        prepareDisposeBag = DisposeBag()
    }

    private func attribute() {
        skillKeyLabel.layer.cornerRadius = 12
        skillKeyLabel.clipsToBounds = true
        skillKeyLabel.backgroundColor = R.color.nestStepLightBlack()
        skillKeyLabel.font = .nestStepBold(size: .medium)
        skillKeyLabel.textColor = R.color.nestStepBrand()
        skillKeyLabel.textAlignment = .center

        skillNameLabel.font = .nestStepRegular(size: .medium)
        skillDescriptionLabel.font = .nestStepRegular(size: .small)
        skillDescriptionLabel.numberOfLines = 0
    }

    private func layout() {
        contentView.addSubViews(skillImageView, skillKeyLabel, skillNameLabel, skillDescriptionLabel)
        skillImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalToSuperview()
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

    func bind(skillstatus: LOLSkillStatus, viewModel: ChampionDetailViewModel) {
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in skillstatus }
            .bind(to: viewModel.skillButtonTap)
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillImageURL }
            .bind(to: skillImageView.rx.imageURLString )
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillStatus.rawValue }
            .bind(to: skillKeyLabel.rx.text)
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillName }
            .bind(to: skillNameLabel.rx.text )
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillDescription }
            .bind(to: skillDescriptionLabel.rx.text)
            .disposed(by: prepareDisposeBag)
    }
}
