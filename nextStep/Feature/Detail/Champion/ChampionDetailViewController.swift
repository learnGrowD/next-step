//
//  ChampionDetailViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailViewController: BaseViewController<ChampionDetailViewModel> {
    private lazy var containerView = ChampionDetailContinerView(viewModel: viewModel)
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()

        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0)
        collectionView.register(
            ChampionDetailBlurCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailBlurCollectionViewCell.identifier
        )
        collectionView.register(
            ChampionDetailDescriptionCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailDescriptionCollectionViewCell.identifier
        )
        collectionView.register(
            ChampionDetailSkillCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailSkillCollectionViewCell.identifier
        )
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    override func layout() {
        super.layout()
        view.addSubViews(containerView, collectionView)

        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: ChampionDetailViewModel) {
        super.bind(viewModel)
        viewModel.getChampionTitleName()
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .bind(to: viewModel.contentOffset)
            .disposed(by: disposeBag)

        viewModel.getChampionDetailPageData()
            .map { _ in [""] }
            .bind(to: collectionView.rx.reloadData())
            .disposed(by: disposeBag)
        
        viewModel.getLayoutStatusList()
            .bind(to: collectionView.rx.items) { collectionView, row, layoutStatus in
                let indexPath = IndexPath(row: row, section: 0)
                switch layoutStatus {
                case .blur:

                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ChampionDetailBlurCollectionViewCell.identifier,
                        for: indexPath
                    ) as? ChampionDetailBlurCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.bind(viewModel)
                    return cell
                case .description:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ChampionDetailDescriptionCollectionViewCell.identifier,
                        for: indexPath
                    ) as? ChampionDetailDescriptionCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.bind(viewModel)
                    return cell
                case .skill(let skillStatus):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ChampionDetailSkillCollectionViewCell.identifier,
                        for: indexPath
                    ) as? ChampionDetailSkillCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.bind(skillstatus: skillStatus, viewModel: viewModel)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}

extension ChampionDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let layout = viewModel.getLayout(indexPath: indexPath)
        switch layout {
        case .blur:
            let width = UIScreen.main.bounds.width
            let height: CGFloat = 56 + 16 + 324 + 32
            return CGSize(width: width, height: height)
        case .description:
            let width = UIScreen.main.bounds.width
            guard let description = viewModel.getChampionDescriptionPrimitive() else { return CGSize(width: width, height: 256)}
            let championNameHeight = description.championName.getBoldHeightSize(size: .medium, width: width - 32, numberOfLines: 1)
            let championDescriptionHeight = description.championDescription.getRegularHeightSize(size: .small, width: width - 32, numberOfLines: 0)
            let between: CGFloat = 16
            let height = between + 40 + between + championNameHeight + between + championDescriptionHeight + 32
            return CGSize(width: width, height: height)
        case .skill(let status):
            let width = UIScreen.main.bounds.width
            guard let skill = viewModel.getChampionSkillPrimitive(skillStatus: status) else {
                return CGSize(width: width, height: 256)
            }
            let skillImageHeight: CGFloat = 56
            let between: CGFloat = 16
            let skillDescription = skill.skillDescription.getRegularHeightSize(size: .small, width: width - 32, numberOfLines: 0)
            let height: CGFloat = skillImageHeight + between + skillDescription + between + 32
            return CGSize(width: width, height: height)
        }
    }
}

