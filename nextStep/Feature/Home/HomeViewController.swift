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
        tableView.backgroundColor = R.color.nestStepBlack()
        tableView.register(HomeBannerTableViewCell.self, forCellReuseIdentifier: HomeBannerTableViewCell.identifier)
    }

    override func layout() {
        super.layout()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
                    cell.bind(viewModel)
                    return cell
                case .top:
                    return UITableViewCell()
                case .jungle:
                    return UITableViewCell()
                case .middle:
                    return UITableViewCell()
                case .bottom:
                    return UITableViewCell()
                case .support:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)
    }
}
