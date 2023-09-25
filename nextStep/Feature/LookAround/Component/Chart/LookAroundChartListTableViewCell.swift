//
//  LookAroundChartListTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LookAroundChartListTableViewCell: UITableViewCell {
    private let diseposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var lookAroundChartAttribute: LookAroundChartAttribute?
    private var viewModel: LookAroundViewModel?

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let pageController = UIPageControl()

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
        containerView.backgroundColor = R.color.nestStepLightBlack()
        containerView
            .layer.cornerRadius = NestStepCornerRadiusCategory.middle.rawValue

        titleLabel.font = .nestStepBold(size: .medium)

        subTitleLabel.font = .nestStepRegular(size: .extraSmall)
        subTitleLabel.textColor = .darkGray

        descriptionLabel.font = .nestStepRegular(size: .small)
        descriptionLabel.textColor = .darkGray

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 12
        let width: CGFloat = UIScreen.main.bounds.width - 32 - 32
        let height: CGFloat = (312 - (12 * 4)) / 5

        flowLayout.itemSize = CGSize(width: width, height: height)

        collectionView.backgroundColor = R.color.nestStepLightBlack()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.rx.setDelegate(self)
            .disposed(by: diseposeBag)
        collectionView.rx.setDataSource(self)
            .disposed(by: diseposeBag)
        collectionView.register(
            LookAroundChartChampionCollectionView.self,
            forCellWithReuseIdentifier: LookAroundChartChampionCollectionView.identifier
        )
    }

    private func layout() {
        contentView.addSubViews(
            containerView,
            titleLabel,
            subTitleLabel,
            descriptionLabel,
            collectionView,
            pageController
        )
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(pageController).inset(-8)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(containerView).inset(16)
        }

        subTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.trailing.lessThanOrEqualTo(containerView)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualTo(containerView)
        }

        collectionView.snp.makeConstraints {
            $0.height.equalTo(312)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(containerView).inset(16)
        }

        pageController.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(56)
        }
    }

    private func setUI(data: LookAroundChartAttribute) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        descriptionLabel.text = data.description
    }

    func bind(viewModel: LookAroundViewModel, data: LookAroundChartAttribute) {
        self.setUI(data: data)
        self.lookAroundChartAttribute = data
        self.viewModel = viewModel

        viewModel.getChartChampionList(champioTagCategory: data.championTagCategory)
            .bind(to: collectionView.rx.reloadData())
            .disposed(by: prepareDisposeBag)

        viewModel.getChartChampionList(champioTagCategory: data.championTagCategory)
            .map {
                $0.count % 5 == 0 ? $0.count / 5 : $0.count / 5 + 1
            }
            .bind(to: pageController.rx.numberOfPages)
            .disposed(by: prepareDisposeBag)

        collectionView.rx.didScroll
            .bind(onNext: { [weak self] in
                self?.didScroll()
            })
            .disposed(by: prepareDisposeBag)
    }
}

extension LookAroundChartListTableViewCell {
    func didScroll() {
        if collectionView.frame.size.width != 0 {
            let value = collectionView.contentOffset.x / collectionView.frame.width
            let indexRow = Int(round(value))
            pageController.currentPage = indexRow
        }
    }
}

extension LookAroundChartListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getChartChampionPrimitiveList(champioTagCategory: lookAroundChartAttribute?.championTagCategory).count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.getChartChampionPrimitiveList(champioTagCategory: lookAroundChartAttribute?.championTagCategory)[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookAroundChartChampionCollectionView.identifier, for: indexPath) as? LookAroundChartChampionCollectionView else { return UICollectionViewCell() }
        cell.bind(viewModel: viewModel, data: data, indexPath: indexPath)
        return cell
    }
}
