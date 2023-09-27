//
//  ChampionCatogoryListView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeChampionCatogoryListTableViewCell: UITableViewCell {
    enum ItemSize {
        case small
        case large
    }
    private let disposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var itemSize: ItemSize?
    private var category: LOLChampionTagCategory?
    private var viewModel: HomeViewModel?

    private let titleLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

    private let collectionViewHeight = HomeChampionSmallCatogoryCollectionViewCell.heightSize
    + "A".getRegularHeightSize(size: .small, width: 164)
    + "A".getRegularHeightSize(size: .extraSmall, width: 164) + 8
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
        titleLabel.font = .nestStepBold(size: .medium)
        titleLabel.text = "A"

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 0

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            HomeChampionSmallCatogoryCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeChampionSmallCatogoryCollectionViewCell.identifier
        )
        collectionView.register(
            HomeChampionLargeCatogoryCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeChampionLargeCatogoryCollectionViewCell.identifier
        )
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
    }

    private func layout() {
        contentView.addSubViews(titleLabel, collectionView)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(56)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func bind(itemSize: ItemSize, _ category: LOLChampionTagCategory, viewModel: HomeViewModel) {
        self.itemSize = itemSize
        self.category = category
        self.viewModel = viewModel

        titleLabel.text = viewModel.getTitle(category: category)
        viewModel.getCategoryList(category: category)
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: prepareDisposeBag)

        switch itemSize {
        case .small:
            collectionView.snp.makeConstraints {
                $0.height.equalTo(collectionViewHeight)
            }
        case .large:
            collectionView.snp.makeConstraints {
                $0.height.equalTo(164)
            }
        }
    }
}

extension HomeChampionCatogoryListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getCategoryPrimitiveList(category: category).count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.getCategoryPrimitiveList(category: category)[indexPath.row]
        
        switch itemSize {
        case .small:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeChampionSmallCatogoryCollectionViewCell.identifier,
                for: indexPath
            ) as? HomeChampionSmallCatogoryCollectionViewCell else { return UICollectionViewCell() }
            cell.bind(viewModel: viewModel, data: data)
            return cell
        case .large:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeChampionLargeCatogoryCollectionViewCell.identifier,
                for: indexPath
            ) as? HomeChampionLargeCatogoryCollectionViewCell else { return UICollectionViewCell() }
            cell.bind(viewModel: viewModel, data: data)
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch itemSize {
        case .small:
            return CGSize(width: 164, height: collectionViewHeight)
        case .large:
            return CGSize(width: 328, height: 164)
        default:
            return CGSize(width: 164, height: 164)
        }

    }
}


