//
//  ChampionDetailContinerView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/28.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailContinerView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: ChampionDetailViewModel
    private lazy var informationView = ChampionDetailInformationView(viewModel: viewModel)
    private lazy var skinListView = ChampionDetailSkinListView(viewModel: viewModel)

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
        skinListView.clipsToBounds = true
    }

    private func layout() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(informationView.intrinsicContentSize.height + 16 + 324)
        }
        addSubViews(informationView, skinListView)
        informationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        skinListView.snp.makeConstraints {
            $0.top.equalTo(informationView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func bind(_ viewModel: ChampionDetailViewModel) {
        viewModel.getContentsOffsetY()
            .bind(onNext: { [weak self] offsetY in
                self?.skinListAlphaFromScroll(offsetY: offsetY)
                self?.skinListSizeAndPositionFromScroll(offsetY: offsetY)
                self?.informationAlphaFromScroll(offsetY: offsetY)
                self?.informationSizeAndPositionFromScroll(offsetY: offsetY)
            })
            .disposed(by: disposeBag)
    }
}

extension ChampionDetailContinerView {
    func skinListAlphaFromScroll(offsetY: CGFloat) {
        let maxAlpha: CGFloat = 1.0
        let minAlpha: CGFloat = 0.0
        let alpha = max(minAlpha, min(maxAlpha, 1 - offsetY / 500))

        skinListView.alpha = alpha
    }

    func skinListSizeAndPositionFromScroll(offsetY: CGFloat) {
        let maxSize: CGFloat = 324.0
        let minSize: CGFloat = 144.0
        let size = max(minSize, maxSize - offsetY / 4)

        skinListView.snp.removeConstraints()
        skinListView.snp.makeConstraints {
            $0.top.equalTo(informationView.snp.bottom).offset(16)
            $0.size.equalTo(size)
            $0.centerX.equalToSuperview()
        }
    }

    func informationAlphaFromScroll(offsetY: CGFloat) {
        let maxAlpha: CGFloat = 1.0
        let minAlpha: CGFloat = 0.0
        let alpha = max(minAlpha, min(maxAlpha, 1 - offsetY / 100))

        informationView.alpha = alpha
    }

    func informationSizeAndPositionFromScroll(offsetY: CGFloat) {
        let topInset = min(0, max(-(safeAreaTopInsets / 1.5) , -offsetY))

        informationView.snp.removeConstraints()
        informationView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(topInset)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
