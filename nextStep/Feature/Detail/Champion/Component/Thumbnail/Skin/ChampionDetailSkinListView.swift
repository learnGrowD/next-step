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

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let size: CGFloat = 256
        flowLayout.itemSize = CGSize(width: size, height: size)

        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            ChampionDetailSkinCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailSkinCollectionViewCell.identifier
        )
    }

    private func layout() {
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(424)
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind(_ viewModel: ChampionDetailViewModel) {
        viewModel.getSkinImageURLList()
            .debug()
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ChampionDetailSkinCollectionViewCell.identifier,
                    for: indexPath
                ) as? ChampionDetailSkinCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.bind(viewModel: viewModel, data: data)
                return cell
             }
            .disposed(by: disposeBag)
    }
}
