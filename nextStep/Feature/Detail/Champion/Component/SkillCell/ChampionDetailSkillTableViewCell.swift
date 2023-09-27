//
//  ChampionDetailSkillTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/27.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailSkillTableViewCell: UITableViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let skillImageView = UIImageView()
    private let skillNameLabel = UILabel()
    private let skillDescriptionLabel = UILabel()
    private let avPlayerContainer = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        skillNameLabel.font = .nestStepRegular(size: .medium)
        skillDescriptionLabel.font = .nestStepRegular(size: .medium)

        avPlayerContainer.backgroundColor = .systemBlue
    }

    private func layout() {
        contentView.addSubViews(skillImageView, skillNameLabel, skillDescriptionLabel, avPlayerContainer)
        skillImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        skillNameLabel.snp.makeConstraints {
            $0.leading.equalTo(skillImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }

        skillDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(skillImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func bind(skillstatus: LOLSkillStatus, viewModel: ChampionDetailViewModel) {

        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillImageURL }
            .bind(to: skillImageView.rx.imageURLString )
            .disposed(by: prepareDisposeBag)
        viewModel.getChampionSkill(skillStatus: skillstatus)
            .map { $0.skillName }
            .bind(to: skillNameLabel.rx.text )
            .disposed(by: prepareDisposeBag)



        avPlayerContainer.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .bind(to: viewModel.avPlayerButtonTap)
            .disposed(by: prepareDisposeBag)
    }
}
