//
//  ChampionDefailSkinListView.swift
//  nextStep/Users/dohagtae/Desktop/next-step/nextStep/nextStep/Feature/Detail/Champion/Component/Thumbnail/Skin/ChampionDetailSkinListView.swift
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
    private let allCountLabel = UILabel()
    private let currentCountLabel = UILabel()

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 324 + 32
        return CGSize(width: width, height: height)
    }
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
        let size: CGFloat = 324
        flowLayout.itemSize = CGSize(width: size, height: size)

        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = NestStepCornerRadiusCategory.middle.rawValue
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            ChampionDetailSkinCollectionViewCell.self,
            forCellWithReuseIdentifier: ChampionDetailSkinCollectionViewCell.identifier
        )

        allCountLabel.font = .nestStepBold(size: .small)
        currentCountLabel.font = .nestStepRegular(size: .small)
    }

    private func layout() {
        snp.makeConstraints {
            $0.width.equalTo(intrinsicContentSize.height)
            $0.height.equalTo(intrinsicContentSize.height)
        }
        addSubViews(collectionView, allCountLabel, currentCountLabel)
        collectionView.snp.makeConstraints {
            $0.size.equalTo(324)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        allCountLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(collectionView).inset(8)
        }

        currentCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(allCountLabel)
            $0.trailing.equalTo(allCountLabel.snp.leading)
        }
    }

    private func bind(_ viewModel: ChampionDetailViewModel) {
        viewModel.skinListSwipeGesture
            .bind(onNext: { [weak self] gesture in
                self?.swipeSkinList(gesture: gesture)
            })
            .disposed(by: disposeBag)

        viewModel.getSkinImageURLList()
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

        viewModel.getSkinImageURLList()
            .map { $0.isEmpty }
            .startWith(true)
            .bind(to: allCountLabel.rx.isHidden, currentCountLabel.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.getSkinImageURLList()
            .map { "\($0.count)"}
            .bind(to: allCountLabel.rx.text)
            .disposed(by: disposeBag)

        collectionView.rx.didScroll
            .map { [weak self] in
                guard let self = self else { return 0 }
                return self.getCurrentCount()
            }
            .map { "\($0 + 1) / "}
            .startWith("1 / ")
            .bind(to: currentCountLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
extension ChampionDetailSkinListView {
    func swipeSkinList(gesture: UISwipeGestureRecognizer) {
        let value = collectionView.contentOffset.x / collectionView.frame.width
        let indexRow = Int(round(value))
        switch gesture.direction {
        case .left:
            if indexRow + 1 <= viewModel.getSkinImageURLListPrimitvie().count - 1 {
                collectionView.scrollToItem(at: IndexPath(row: indexRow + 1, section: 0), at: .left, animated: true)
            }
        case .right:
            if indexRow - 1 >= 0 {
                collectionView.scrollToItem(at: IndexPath(row: indexRow - 1, section: 0), at: .left, animated: true)
            }
        default: break
        }
    }

    func getCurrentCount() -> Int {
        let value = collectionView.contentOffset.x / collectionView.frame.width
        let result = Int(round(value))
        return result
    }
}
