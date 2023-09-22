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
    private var disposeBag = DisposeBag()
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
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
        disposeBag = DisposeBag()
    }

    func bind(_ viewModel: HomeViewModel) {
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
    }
    
    private func attribute() {
        selectionStyle = .none

        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 308 + safeAreaTopInsets
        )

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBlue
        collectionView.register(
            HomeBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeBannerCollectionViewCell.identifier
        )
    }

    private func layout() {
        contentView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(316)
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
        }
    }
}
