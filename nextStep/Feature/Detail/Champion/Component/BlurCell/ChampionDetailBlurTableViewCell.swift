//
//  ChampionDetailBlurCollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailBlurCollectionViewCell: UICollectionViewCell {
    private var prepareDisposeBag = DisposeBag()
    private let informationAreaView = UIView()
    private let skinListAreaView = UIView()
    private let likeButton = UIView()
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
        contentView.backgroundColor = .clear
    }

    private func layout() {
        contentView.snp.makeConstraints {
            $0.height.equalTo(56 + 16 + 324 + 32)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        contentView.addSubViews(informationAreaView, skinListAreaView)
        informationAreaView.snp.makeConstraints {
            $0.top.equalToSuperview()
            let height = "A".getRegularHeightSize(size: .small, width: 100, numberOfLines: 1) + 32
            $0.height.equalTo(height)
            $0.leading.trailing.equalToSuperview()
        }
        informationAreaView.addSubview(likeButton)
        likeButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(8)
        }
        skinListAreaView.snp.makeConstraints {
            $0.top.equalTo(informationAreaView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func bind(_ viewModel: ChampionDetailViewModel) {

        skinListAreaView.rx.swipeGesture(.left, .right)
            .when(.recognized)
            .bind(to: viewModel.skinListSwipeGesture)
            .disposed(by: prepareDisposeBag)

        likeButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in
                var isLike = viewModel.isLike.value
                return !isLike
            }
            .bind(to: viewModel.likeButtonTap)
            .disposed(by: prepareDisposeBag)
    }
}
