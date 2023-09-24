//
//  LookAroundViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

final class LookAroundViewController: BaseViewController<LookAroundViewModel> {
    private let titleNavigationLabel = UILabel()

    private let categoryFlowLayout = UICollectionViewFlowLayout()
    private lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryFlowLayout)

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        titleNavigationLabel.font = .nestStepBold(size: .large)
        titleNavigationLabel.text = R.string.localizable.lookAroundViewControllerTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleNavigationLabel)

        categoryFlowLayout.scrollDirection = .horizontal
        categoryFlowLayout.minimumLineSpacing = 0
        categoryFlowLayout.minimumInteritemSpacing = 8

        categoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.register(
            LookAroundCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: LookAroundCategoryCollectionViewCell.identifier
        )
        categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    override func layout() {
        super.layout()
        view.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
    override func bind(_ viewModel: LookAroundViewModel) {
        super.bind(viewModel)

        viewModel.categoryList
            .bind(to: categoryCollectionView.rx.items) { collectionView, row, data in
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

extension LookAroundViewController: UICollectionViewDelegateFlowLayout {
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
