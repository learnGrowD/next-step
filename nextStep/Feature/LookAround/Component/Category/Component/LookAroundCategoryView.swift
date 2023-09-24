//
//  LookAroundCategoryView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LookAroundCategoryView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: LookAroundViewModel
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

    init(frame: CGRect = .zero, viewModel: LookAroundViewModel) {
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
        flowLayout.minimumInteritemSpacing = 8

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            LookAroundCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: LookAroundCategoryCollectionViewCell.identifier
        )
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    private func layout() {
        addSubview(collectionView)
        snp.makeConstraints {
            $0.height.equalTo(40)
        }
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func bind(_ viewModel: LookAroundViewModel) {
        viewModel.getCategoryList()
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LookAroundCategoryCollectionViewCell.identifier,
                    for: indexPath
                ) as? LookAroundCategoryCollectionViewCell else { return UICollectionViewCell() }
                cell.bind(viewModel: viewModel, data: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension LookAroundCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let dummyCell = LookAroundCategoryCollectionViewCell()
        dummyCell.setUI(data: viewModel.categoryList.value[indexPath.row])
        return dummyCell.intrinsicContentSize
    }
}
