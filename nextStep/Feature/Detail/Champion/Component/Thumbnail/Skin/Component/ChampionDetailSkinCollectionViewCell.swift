//
//  ChampionDetailSkinCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailSkinCollectionViewCell: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let thumnailImageView = UIImageView()
    private let nameLabel = UILabel()

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
        thumnailImageView.clipsToBounds = true
        nameLabel.font = .nestStepRegular(size: .medium)
    }

    private func layout() {
        contentView.addSubViews(thumnailImageView, nameLabel)
        thumnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(8)
        }
    }

    private func setUI(data: ChampionDetailSkinAttribute) {
        thumnailImageView.bindImage(imageURL: data.skinImageURL)
        nameLabel.text = data.skinName
    }

    func bind(viewModel: ChampionDetailViewModel, data: ChampionDetailSkinAttribute) {
        setUI(data: data)
    }
}
