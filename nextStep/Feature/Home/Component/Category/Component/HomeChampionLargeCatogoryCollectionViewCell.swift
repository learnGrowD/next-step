//
//  HomeChampionLargeCatogoryCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeChampionLargeCatogoryCollectionViewCell: HomeChampionCatogoryCollectionViewCell {
    override func attribute() {
        super.attribute()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        contentView.layer.cornerRadius = NestStepCornerRadiusCategory.small.rawValue
        contentView.backgroundColor = R.color.nestStepLightBlack()
    }

    override func layout() {
        super.layout()
        
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(164)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(nameLabel)
        }
    }
}
