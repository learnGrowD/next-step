//
//  LookAroundChartChampionCollectionView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LookAroundChartChampionCollectionView: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let thumbnailImageView = UIImageView()
    private let rankTitleLabel = UILabel()
    private let championNameLabel = UILabel()
    private let championDescriptionLabel = UILabel()

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
        contentView.backgroundColor = R.color.nestStepLightBlack()
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = NestStepCornerRadiusCategory.small.rawValue

        rankTitleLabel.font = .nestStepBold(size: .medium)

        championNameLabel.font = .nestStepBold(size: .small)

        championDescriptionLabel.font = .nestStepRegular(size: .extraSmall)
        championDescriptionLabel.textColor = .white.withAlphaComponent(0.5)
    }

    private func layout() {
        contentView.addSubViews(thumbnailImageView, rankTitleLabel, championNameLabel, championDescriptionLabel)
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        rankTitleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView).inset(4)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
        }

        championNameLabel.snp.makeConstraints {
            $0.top.equalTo(rankTitleLabel)
            $0.leading.equalTo(rankTitleLabel.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview()
        }

        championDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(championNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(championNameLabel)
        }
    }

    private func setUI(data: LookAroundChampionRankAttribute, indexPath: IndexPath) {
        thumbnailImageView.bindImage(imageURL: data.championImageURL)
        rankTitleLabel.text = "\(indexPath.row + 1)"
        championNameLabel.text = data.championName
        championDescriptionLabel.text = data.champioDescription
    }

    func bind(
        viewModel: LookAroundViewModel,
        data: LookAroundChampionRankAttribute,
        indexPath: IndexPath
    ) {
        setUI(data: data, indexPath: indexPath)
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in data }
            .bind(to: viewModel.chartChampionButtonTap)
            .disposed(by: prepareDisposeBag)
    }
}
