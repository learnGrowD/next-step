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
    private var disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

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
        disposeBag = DisposeBag()
    }

    private func attribute() {
        contentView.backgroundColor = .systemBlue
        titleLabel.font = .nestStepBold(size: .medium)

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        let size: CGFloat = 164
        flowLayout.itemSize = CGSize(width: size, height: size + 24)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            HomeChampionCatogoryCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeChampionCatogoryCollectionViewCell.identifier
        )
    }

    private func layout() {
        contentView.addSubViews(titleLabel, collectionView)
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(208 + 88)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.height.equalTo(164)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(88)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func bind(category: LOLChampionTagCategory, viewModel: HomeViewModel) {
        titleLabel.text = viewModel.getTitle(category: category)
        viewModel.getCategoryList(category: category)
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeChampionCatogoryCollectionViewCell.identifier,
                    for: indexPath
                ) as? HomeChampionCatogoryCollectionViewCell else { return UICollectionViewCell() }
                cell.bind(viewModel: viewModel, data: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
