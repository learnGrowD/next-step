//
//  LookAroundViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

final class LookAroundViewController: BaseViewController<LookAroundViewModel> {
    private let titleNavigationLabel = UILabel()
    private lazy var categoryView = LookAroundCategoryView(viewModel: viewModel)
    private let tableView = UITableView()

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        titleNavigationLabel.font = .nestStepBold(size: .large)
        titleNavigationLabel.text = R.string.localizable.lookAroundViewControllerTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleNavigationLabel)

        tableView.register(
            LookAroundChartListTableViewCell.self,
            forCellReuseIdentifier: LookAroundChartListTableViewCell.identifier
        )
        tableView.register(
            LookAroundInterestedListTableViewCell.self,
            forCellReuseIdentifier: LookAroundInterestedListTableViewCell.identifier
        )
        
    }
    override func layout() {
        super.layout()
        view.addSubViews(categoryView, tableView)
        categoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 192, right: 0)
        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    override func bind(_ viewModel: LookAroundViewModel) {
        super.bind(viewModel)

        viewModel.getLayoutStatusList()
            .bind(to: tableView.rx.items) { tableView, row, layoutStatus in
                let indexPath = IndexPath(row: row, section: 0)
                switch layoutStatus {
                case .chart(let lookAroundChartAttribute):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: LookAroundChartListTableViewCell.identifier,
                        for: indexPath
                    ) as? LookAroundChartListTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.bind(viewModel: viewModel, data: lookAroundChartAttribute)
                    return cell
                case .interestedGroup(let interestedStatus):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: LookAroundInterestedListTableViewCell.identifier,
                        for: indexPath
                    ) as? LookAroundInterestedListTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.bind(viewModel: viewModel, lookAroundInterestedStatus: interestedStatus)
                    return cell
                }
            }
            .disposed(by: disposeBag)

        view.rx.swipeGesture(.left, .up, .right, .down)
            .when(.recognized)
            .map { _ in true }
            .bind(to: viewModel.isDidScrollEnabled)
            .disposed(by: disposeBag)

        tableView.rx.didScroll
            .flatMap { viewModel.isDidScrollEnabled }
            .filter { $0 }
            .bind(onNext: { [weak self] _ in
                self?.scrollSelectCategory()
            })
            .disposed(by: disposeBag)


        viewModel.getTopCategoryButtonTapWithLayoutPositionIndex()
            .bind(onNext: { [weak self] layoutPositionIndex in
                self?.selectCategory(index: layoutPositionIndex)
                self?.scrollToCategory(layoutPositionIndex: layoutPositionIndex)
            })
            .disposed(by: disposeBag)

        viewModel.getChartChampioButtonTapWithChampionID()
            .bind(onNext: { [weak self] championID in
                self?.pushChampionDetailViewController(championID: championID)
            })
            .disposed(by: disposeBag)

        viewModel.getInterestedGroupButtonTapWithTitle()
            .bind(onNext: { [weak self] title in
                self?.showInterestedTitleToast(title: title)
            })
            .disposed(by: disposeBag)
    }
}

extension LookAroundViewController {
    private func scrollSelectCategory() {
        let visibleIndexPaths = tableView.indexPathsForVisibleRows ?? []
        if let indexPath = visibleIndexPaths.first {
            selectCategory(index: indexPath.row)
        }
    }
    private func selectCategory(index: Int) {
        viewModel.updateSelectTopCategoryList(categoryIndex: index)
    }
    private func scrollToCategory(layoutPositionIndex: Int) {
        let indexPath = IndexPath(row: layoutPositionIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    private func pushChampionDetailViewController(championID: String) {
        print("champion ID: \(championID)")
    }
    private func showInterestedTitleToast(title: String) {
        print("title: \(title)")
    }
}
