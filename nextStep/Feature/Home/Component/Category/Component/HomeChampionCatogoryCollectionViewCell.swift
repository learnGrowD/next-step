//
//  HomeChampionCatogoryCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeChampionCatogoryCollectionViewCell: UICollectionViewCell {
    private var disposeBag = DisposeBag()
    private let thumbnailImageView = UIImageView()
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()

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

    private func attribute() {}

    private func layout() {
        contentView.addSubViews(thumbnailImageView, nameLabel, titleLabel)
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(4)
            $0.leading.equalTo(thumbnailImageView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(thumbnailImageView)
            $0.bottom.equalToSuperview()
        }
    }

    func bind(viewModel: HomeViewModel, data: HomeChampionCategoryAttribute) {
        setUI(data: data)
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in data }
            .bind(to: viewModel.categoryButtonTap)
            .disposed(by: disposeBag)
    }

    private func setUI(data: HomeChampionCategoryAttribute) {
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = NestStepCornerRadiusCategory.small.rawValue
        let thumbnailImageURL = RiotAPIRequestContext.getChampionImageURL(
            championImageSizeStatus: .full,
            championID: data.id,
            skinIndexNumber: 0
        )
        thumbnailImageView.bindImage(imageURL: thumbnailImageURL)

        nameLabel.font = .nestStepRegular(size: .medium)
        nameLabel.textColor = .white

        titleLabel.font = .nestStepRegular(size: .small)
        titleLabel.textColor = .white
    }
}
