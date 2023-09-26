//
//  HomeChampionCatogoryCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class HomeChampionCatogoryCollectionViewCell: UICollectionViewCell {
    static var heightSize: CGFloat { 164 }
    private var disposeBag = DisposeBag()
    let thumbnailImageView = UIImageView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()

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

    func attribute() {
        nameLabel.font = .nestStepRegular(size: .small)
        nameLabel.textColor = .white

        titleLabel.font = .nestStepRegular(size: .extraSmall)
        titleLabel.textColor = .white
    }

    func layout() {
        contentView.addSubViews(thumbnailImageView, nameLabel, titleLabel)
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
        thumbnailImageView.bindImage(imageURL: data.thumbnailImageURL)

        nameLabel.text = data.championName
        titleLabel.text = data.title
    }
}
