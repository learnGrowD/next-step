//
//  LookAroundInterestedCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LookAroundInterestedCollectionViewCell: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()

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
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = NestStepCornerRadiusCategory.small.rawValue

        titleLabel.font = .nestStepRegular(size: .medium)
    }

    private func layout() {
        contentView.addSubViews(backgroundImageView, titleLabel, iconImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        iconImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func setUI(data: LookAroundInterestedGroupAttribute) {
        backgroundImageView.bindImage(imageURL: data.backgroundImageURL)
        titleLabel.text = data.title

        iconImageView.image = data.iconImageUIImage
    }

    func bind(viewModel: LookAroundViewModel, data: LookAroundInterestedGroupAttribute) {
        setUI(data: data)
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in data }
            .bind(to: viewModel.interestedButtonTap)
            .disposed(by: prepareDisposeBag)
    }
}
