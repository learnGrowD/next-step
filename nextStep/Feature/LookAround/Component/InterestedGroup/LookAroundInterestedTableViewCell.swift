//
//  LookAroundInterestedListTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LookAroundInterestedListTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var lookAroundInterestedStatus: LookAroundInterestedStatus?
    private var viewModel: LookAroundViewModel?

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
        prepareDisposeBag = DisposeBag()
    }

    private func attribute() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 32
        flowLayout.minimumInteritemSpacing = 16
        let width: CGFloat = (UIScreen.main.bounds.width - 32 - 16) / 2
        let height: CGFloat = 104
        flowLayout.itemSize = CGSize(width: width, height: height)

        collectionView.backgroundColor = R.color.nestStepBlack()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        collectionView.register(
            LookAroundInterestedCollectionViewCell.self,
            forCellWithReuseIdentifier: LookAroundInterestedCollectionViewCell.identifier
        )
    }

    private func layout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(56)
        }
    }

    func bind(viewModel: LookAroundViewModel, lookAroundInterestedStatus: LookAroundInterestedStatus) {
        self.viewModel = viewModel
        self.lookAroundInterestedStatus = lookAroundInterestedStatus

        viewModel.getInterestedGroupList(interestedStatus: lookAroundInterestedStatus)
            .bind(to: collectionView.rx.reloadData())
            .disposed(by: prepareDisposeBag)

        //TODO: height size 결정해주기
        viewModel.getInterestedGroupList(interestedStatus: lookAroundInterestedStatus)
            .bind(onNext: { [weak self] list in
                self?.conformHeightSize(list: list)
            })
            .disposed(by: prepareDisposeBag)
    }
}

extension LookAroundInterestedListTableViewCell {
    func conformHeightSize(list: [LookAroundInterestedGroupAttribute]) {
        let quotient = (list.count / 2)
        collectionView.snp.makeConstraints {
            $0.height.equalTo((quotient + 1) * 104 + (quotient * 32))
        }
    }
}

extension LookAroundInterestedListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getInterestedGroupPrimitiveList(interestedStatus: lookAroundInterestedStatus).count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.getInterestedGroupPrimitiveList(interestedStatus: lookAroundInterestedStatus)[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LookAroundInterestedCollectionViewCell.identifier,
            for: indexPath
        ) as? LookAroundInterestedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(viewModel: viewModel, data: data)
        return cell
    }
}
