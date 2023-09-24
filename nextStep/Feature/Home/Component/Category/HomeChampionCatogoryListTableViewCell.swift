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
    private let disposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var category: LOLChampionTagCategory?
    private var viewModel: HomeViewModel?

    private let titleLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

    private let collectionViewHeight = 164
    + String.getRegularHeightSize(size: .small)
    + String.getRegularHeightSize(size: .extraSmall) + 8
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
        contentView.backgroundColor = .systemBlue
        titleLabel.font = .nestStepBold(size: .medium)
        titleLabel.text = "A"

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0

        let width: CGFloat = 164
        let height: CGFloat = collectionViewHeight
        flowLayout.itemSize = CGSize(width: width, height: height)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            HomeChampionCatogoryCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeChampionCatogoryCollectionViewCell.identifier
        )
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
    }

    private func layout() {
        contentView.addSubViews(titleLabel, collectionView)
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            let height = titleLabel.intrinsicContentSize.height + collectionViewHeight + 16 + 88
            $0.height.equalTo(height)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.height.equalTo(collectionViewHeight)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(88)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func bind(_ category: LOLChampionTagCategory, viewModel: HomeViewModel) {
        self.category = category
        self.viewModel = viewModel
        titleLabel.text = viewModel.getTitle(category: category)
        viewModel.getCategoryList(category: category)
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: prepareDisposeBag)
    }
}

extension HomeChampionCatogoryListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getCategoryPrimitiveList(category: category).count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.getCategoryPrimitiveList(category: category)[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeChampionCatogoryCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeChampionCatogoryCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(viewModel: viewModel, data: data)
        return cell
    }
}


