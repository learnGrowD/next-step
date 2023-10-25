//
//  GalleyInformationTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/10/12.
//

import UIKit
import RxSwift
import RxCocoa

final class GalleyInformationTableViewCell: UITableViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let iconImageView = UIImageView()
    private let informationLabel = UILabel()
    private let informationUnderlineView = UIView()

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

        iconImageView.tintColor = .white

        informationLabel.font = .nestStepRegular(size: .small)
        informationLabel.textColor = .systemBlue

        informationUnderlineView.backgroundColor = .systemBlue
    }

    private func layout() {
        contentView.addSubViews(iconImageView, informationLabel, informationUnderlineView)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
        informationLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        informationUnderlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalTo(informationLabel)
            $0.leading.trailing.equalTo(informationLabel).inset(4)
        }
    }

    private func setUI(data: GalleryInformationAttribute) {
        iconImageView.image = UIImage(systemName: data.iconImageName)
        informationLabel.text = " \(data.description): \(data.link)"
    }

    func bind(data: GalleryInformationAttribute, viewModel: IntroViewModel) {
        setUI(data: data)
        Observable.merge(
            informationLabel.rx.tapGesture().when(.recognized),
            informationUnderlineView.rx.tapGesture().when(.recognized)
        )
        .map { _ in data }
        .bind(to: viewModel.informationButtonTap)
        .disposed(by: prepareDisposeBag)
    }
}
