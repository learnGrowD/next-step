//
//  MainBannerCollectionView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeBannerView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let pageControll = UIPageControl()

    init(frame: CGRect = .zero, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: HomeBannerCollectionViewCell.heightSize
        )
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(
            HomeBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeBannerCollectionViewCell.identifier
        )
        pageControll.numberOfPages = 1
    }

    private func layout() {
        addSubViews(collectionView, pageControll)
        frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: HomeBannerCollectionViewCell.heightSize + 8 + pageControll.intrinsicContentSize.height + 24
        )

        collectionView.snp.makeConstraints {
            $0.height.equalTo(HomeBannerCollectionViewCell.heightSize)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        pageControll.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }
    }

    func bind(viewModel: HomeViewModel) {
        viewModel.getHomeBannerList()
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeBannerCollectionViewCell.identifier,
                    for: indexPath
                ) as? HomeBannerCollectionViewCell else { return UICollectionViewCell() }
                cell.bind(viewModel: viewModel, data: data)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.getHomeBannerList()
            .map { $0.count }
            .bind(to: pageControll.rx.numberOfPages)
            .disposed(by: disposeBag)

        collectionView.rx.didScroll
            .bind(onNext: { [weak self] in
                self?.didScroll()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeBannerView {
    func didScroll() {
        if collectionView.frame.size.width != 0 {
            let value = collectionView.contentOffset.x / collectionView.frame.width
            let indexRow = Int(round(value))
            pageControll.currentPage = indexRow
        }
    }
}
