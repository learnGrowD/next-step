//
//  HomeBannerCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeBannerCollectionViewCell: UICollectionViewCell {
    private var disposeBag = DisposeBag()
    private let backgroundImageView = UIImageView()
    private let recommendLabel = UILabel()
    private let titleLabel = UILabel()

    private let skinCountAndDateLabel = UILabel()
    private let centerThubnailImageView = UIImageView()
    private let leftThumbnailImageView = UIImageView()
    private let rightThumbnailImageView = UIImageView()
    private let championInformationLabel = UILabel()

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
        disposeBag = DisposeBag()
    }

    private func attribute() {
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill

        recommendLabel.font = .nestStepRegular(size: .small)
        recommendLabel.textColor = .white

        titleLabel.font = .nestStepBold(size: .extraLarge)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        skinCountAndDateLabel.font = .nestStepRegular(size: .extraSmall)
        skinCountAndDateLabel.textColor = .white

        centerThubnailImageView.layer.zPosition = 2
        centerThubnailImageView.clipsToBounds = true
        centerThubnailImageView.layer.cornerRadius = 72
        centerThubnailImageView.contentMode = .scaleAspectFill

        leftThumbnailImageView.layer.zPosition = 1
        leftThumbnailImageView.clipsToBounds = true
        leftThumbnailImageView.layer.cornerRadius = 48
        leftThumbnailImageView.contentMode = .scaleAspectFill

        rightThumbnailImageView.layer.zPosition = 1
        rightThumbnailImageView.clipsToBounds = true
        rightThumbnailImageView.layer.cornerRadius = 48
        rightThumbnailImageView.contentMode = .scaleAspectFill

        championInformationLabel.font = .nestStepRegular(size: .extraSmall)
        championInformationLabel.textColor = .white
    }

    private func layout() {
        contentView.addSubViews(
            backgroundImageView,
            recommendLabel,
            titleLabel,
            skinCountAndDateLabel,
            centerThubnailImageView,
            leftThumbnailImageView,
            rightThumbnailImageView,
            championInformationLabel
        )

        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        recommendLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(safeAreaTopInsets)
            $0.leading.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(8)
            $0.leading.equalTo(recommendLabel)
        }
        skinCountAndDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalTo(recommendLabel)
        }
        centerThubnailImageView.snp.makeConstraints {
            $0.size.equalTo(144)
            $0.top.equalTo(skinCountAndDateLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        leftThumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(96)
            $0.centerY.equalTo(centerThubnailImageView)
            $0.trailing.equalTo(centerThubnailImageView.snp.leading).offset(24)
        }
        rightThumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(96)
            $0.centerY.equalTo(centerThubnailImageView)
            $0.leading.equalTo(centerThubnailImageView.snp.trailing).offset(-24)
        }
        championInformationLabel.snp.makeConstraints {
            $0.top.equalTo(centerThubnailImageView.snp.bottom).offset(8)
            $0.leading.equalTo(recommendLabel)
        }
    }

    func bind(viewModel: HomeViewModel, data: HomeBannerItemAttribute) {
        setUI(data: data)
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in data }
            .bind(to: viewModel.homeBannerButtonTap)
            .disposed(by: disposeBag)
    }

    private func setUI(data: HomeBannerItemAttribute) {
        backgroundImageView.bindImage(imageURL: data.backgroundImageURL)
        recommendLabel.text = R.string.localizable.homeBannerCollectionViewCellRecommend(data.categoryText)
        titleLabel.text = data.title
        let dateString = data.date.toString(format: "yyyy.MM.dd")
        skinCountAndDateLabel.text = R.string.localizable.homeBannerCollectionViewCellSkinCount(data.allCount, dateString)
        [
            centerThubnailImageView,
            leftThumbnailImageView,
            rightThumbnailImageView
        ].enumerated().forEach { index, imageView in
            imageView.bindImage(imageURL: data.skinImageURLList[index])
        }
        championInformationLabel.text = "\(data.championInformation)"
    }
}
