//
//  ChampionDetailDescriptionTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailDescriptionTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    private var prepareDisposeBag = DisposeBag()
    private var viewModel: ChampionDetailViewModel?

    private let tagFlowLayout = UICollectionViewFlowLayout()
    private lazy var tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tagFlowLayout)
    private let championNameLabel = UILabel()
    private let championTitleLabel = UILabel()
    private let championDescriptionLabel = UILabel()

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
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        tagFlowLayout.scrollDirection = .horizontal
        tagFlowLayout.minimumLineSpacing = 0
        tagFlowLayout.minimumInteritemSpacing = 8

        tagCollectionView.backgroundColor = .clear
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.register(
            ChampionDetailDescriptionTagCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailDescriptionTagCollectionViewCell.identifier
        )
        tagCollectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)

        tagCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        championNameLabel.font = .nestStepBold(size: .medium)

        championTitleLabel.font = .nestStepRegular(size: .small)
        championTitleLabel.textColor = .white.withAlphaComponent(0.7)

        championDescriptionLabel.font = .nestStepRegular(size: .small)
        championDescriptionLabel.numberOfLines = 3
    }

    private func layout() {
        contentView.addSubViews(tagCollectionView, championNameLabel, championTitleLabel, championDescriptionLabel)

        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            let hegith = 16 + 40 + 16 + String.getBoldHeightSize(size: .medium) + 8 + String.getRegularHeightSize(size: .small, textLine: 3)
            $0.height.equalTo(hegith)
        }

        tagCollectionView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        championNameLabel.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        championTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(championNameLabel)
            $0.leading.equalTo(championNameLabel.snp.trailing)
        }

        championDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(championNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    func bind(_ viewModel: ChampionDetailViewModel) {
        self.viewModel = viewModel

        viewModel.getChampionDescription()
            .map { $0.tagList }
            .bind(to: tagCollectionView.rx.reloadData())
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionDescription()
            .map { $0.championName }
            .bind(to: championNameLabel.rx.text)
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionDescription()
            .map { " - \($0.championTItle)" }
            .bind(to: championTitleLabel.rx.text)
            .disposed(by: prepareDisposeBag)

        viewModel.getChampionDescription()
            .map { $0.championDescription }
            .bind(to: championDescriptionLabel.rx.text)
            .disposed(by: prepareDisposeBag)
    }
}

extension ChampionDetailDescriptionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getChampionDescriptionPrimitive()?.tagList.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tagList = viewModel?.getChampionDescriptionPrimitive()?.tagList else { return UICollectionViewCell() }
        let data = tagList[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChampionDetailDescriptionTagCollectionViewCell.identifier,
            for: indexPath) as? ChampionDetailDescriptionTagCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setUI(data: data)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let dummyCell = ChampionDetailDescriptionTagCollectionViewCell()
        guard let tagList = viewModel?.getChampionDescriptionPrimitive()?.tagList else { return CGSize(width: 88, height: 40) }
        let data = tagList[indexPath.row]
        dummyCell.setUI(data: data)
        return dummyCell.intrinsicContentSize
    }
}
