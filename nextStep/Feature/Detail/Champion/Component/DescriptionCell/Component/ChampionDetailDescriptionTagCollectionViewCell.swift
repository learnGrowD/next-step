//
//  ChampionDetailDescriptionTagCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/27.
//

import Foundation
import RxSwift
import RxCocoa

final class ChampionDetailDescriptionTagCollectionViewCell: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let categoryLabel = UILabel()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = 16 + categoryLabel.intrinsicContentSize.width + 16
        let height: CGFloat = 4 + 32 + 4
        return CGSize(width: width, height: height)
    }
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
        backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = R.color.nestStepBrand()

        categoryLabel.font = .nestStepRegular(size: .small)
    }

    private func layout() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setUI(data: String) {
        categoryLabel.text = data
    }
}
