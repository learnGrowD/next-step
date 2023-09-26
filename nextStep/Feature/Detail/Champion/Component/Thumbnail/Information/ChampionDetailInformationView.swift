//
//  ChampionDetailInformationView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailInformationView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: ChampionDetailViewModel

    private let titleLable = UILabel()
    private let likeButton = UIImageView()


    init(frame: CGRect = .zero, viewModel: ChampionDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        titleLable.font = .nestStepRegular(size: .small)
        titleLable.text = R.string.localizable.championDetailInformationViewTitle()

        likeButton.tintColor = .systemRed
        likeButton.image = UIImage(systemName: "heart")
    }

    private func layout() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(56)
        }
        addSubViews(titleLable, likeButton)
        titleLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        likeButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func bind(_ viewModel: ChampionDetailViewModel) {

    }
}