//
//  ChampionDefailSkinListView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailSkinListView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: ChampionDetailViewModel
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

    }

    private func layout() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(424)
        }

    }

    private func bind(_ viewModel: ChampionDetailViewModel) {

    }
}
