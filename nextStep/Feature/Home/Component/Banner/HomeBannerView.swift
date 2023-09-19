//
//  MainBannerCollectionView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

final class HomeBannerView: UIView {
    private let viewModel: HomeViewModel
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    private let pageControll = UIPageControl()

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let collectionViewHeight: CGFloat = 416
        let pageControllHeight: CGFloat = pageControll.intrinsicContentSize.height
        let height: CGFloat = collectionViewHeight + 8 + pageControllHeight
        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(viewModel)
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: HomeViewModel) {

    }

    private func attribute() {
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.itemSize = CGSize(
            width: intrinsicContentSize.width,
            height: intrinsicContentSize.height
        )

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = R.color.nestStepBlack()
    }

    private func layout() {
        addSubViews(collectionView, pageControll)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(416)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        pageControll.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
