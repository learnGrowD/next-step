//
//  LookAroundtopCategoryListTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LookAroundCategoryCollectionViewCell: UICollectionViewCell {
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
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = R.color.nestStepLightBlack()

        categoryLabel.font = .nestStepRegular(size: .medium)
    }

    private func layout() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }

    func bind(viewModel: LookAroundViewModel, data: LookAroundCategoryAttribute) {
        setUI(data: data)
        contentView.rx.tapGesture()
            .map { _ in data }
            .bind(to: viewModel.topCategoryButtonTap)
            .disposed(by: prepareDisposeBag)
    }

    func setUI(data: LookAroundCategoryAttribute) {
        categoryLabel.text = data.categoryText
        if data.isSelect {
            contentView.backgroundColor = R.color.nestStepBrand()
        } else {
            contentView.backgroundColor = R.color.nestStepLightBlack()
        }
    }
}
