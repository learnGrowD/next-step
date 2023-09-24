//
//  MainBannerCollectionView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeBannerTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var viewModel: HomeViewModel?

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let pageControll = UIPageControl()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 308 + safeAreaTopInsets
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(
            HomeBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeBannerCollectionViewCell.identifier
        )
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        collectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)
    }

    private func layout() {
        contentView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(316 + 32)
        }
        contentView.addSubViews(collectionView, pageControll)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(308 + safeAreaTopInsets)
            $0.top.equalToSuperview().inset(-safeAreaTopInsets)
            $0.leading.trailing.equalToSuperview()
        }
        pageControll.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
    }

    func bind(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        viewModel.getHomeBannerList()
            .debug()
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: prepareDisposeBag)
    }
}

extension HomeBannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getHomeBannerPrimitiveList().count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.getHomeBannerPrimitiveList()[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeBannerCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeBannerCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(viewModel: viewModel, data: data)
        return cell
    }
}
