//
//  BetweenBannerTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeBetweenBannerTableViewCell: UITableViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private lazy var informationStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
    private let iconImageView = UIImageView()

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
        backgroundImageView.clipsToBounds = true
        titleLabel.font = .nestStepBold(size: .medium)

        descriptionLabel.font = .nestStepRegular(size: .small)

        informationStackView.axis = .vertical
        informationStackView.spacing = 8
    }

    private func layout() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubViews(informationStackView, iconImageView)
        backgroundImageView.snp.makeConstraints {
            $0.height.equalTo(104)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(56)
        }
        informationStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    private func setUI(data: HomeBetweenBannerAttribute?) {
        backgroundImageView.bindImage(imageURL: data?.backgroundImageURL)
        titleLabel.text = data?.title
        descriptionLabel.text = data?.description
        iconImageView.image = data?.decorateIconImage
    }

    func bind(_ viewModel: HomeViewModel, data: HomeBetweenBannerAttribute?) {
        setUI(data: data)
        contentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in data }
            .bind(to: viewModel.betweenBannerButtonTap)
            .disposed(by: prepareDisposeBag)
    }

}
