//
//  HomeViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    private let tableView = UITableView()

    override func attribute() {
        super.attribute()
        tableView.separatorStyle = .none
        tableView.register(HomeBannerTableViewCell.self, forCellReuseIdentifier: HomeBannerTableViewCell.identifier)
        tableView.register(HomeChampionCatogoryListTableViewCell.self,
                           forCellReuseIdentifier: HomeChampionCatogoryListTableViewCell.identifier)
    }

    override func layout() {
        super.layout()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    override func bind(_ viewModel: HomeViewModel) {
        super.bind(viewModel)
        viewModel.getHomeLayoutCategoryList()
            .bind(to: tableView.rx.items) { tableView, row, category in
                let indexPath = IndexPath(row: row, section: 0)
                switch category {
                case .banner:
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeBannerTableViewCell.identifier,
                        for: indexPath
                    ) as? HomeBannerTableViewCell else { return UITableViewCell() }
                    cell.bind(viewModel: viewModel)
                    return cell

                case .small(let category):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeChampionCatogoryListTableViewCell.identifier,
                        for: indexPath
                    ) as? HomeChampionCatogoryListTableViewCell else { return UITableViewCell() }
                    cell.bind(category, viewModel: viewModel)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}
