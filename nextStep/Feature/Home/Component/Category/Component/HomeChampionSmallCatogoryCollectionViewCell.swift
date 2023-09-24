//
//  HomeChampionSmallCatogoryCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeChampionSmallCatogoryCollectionViewCell: HomeChampionCatogoryCollectionViewCell {
    override func layout() {
        super.layout()
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(164)
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
}
