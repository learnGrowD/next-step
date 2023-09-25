//
//  HomeViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController<HomeViewModel> {
    private let tableView = UITableView()

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        tableView.register(HomeBannerTableViewCell.self, forCellReuseIdentifier: HomeBannerTableViewCell.identifier)
        tableView.register(HomeBetweenBannerTableViewCell.self,
                           forCellReuseIdentifier: HomeBetweenBannerTableViewCell.identifier)
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
        viewModel.gethomeLayoutStatusList()
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
                case .betweenBanner(let betweenBannerAttribute):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeBetweenBannerTableViewCell.identifier,
                        for: indexPath
                    ) as? HomeBetweenBannerTableViewCell else { return UITableViewCell() }
                    cell.bind(viewModel, data: betweenBannerAttribute)
                    return cell
                case .small(let category):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeChampionCatogoryListTableViewCell.identifier,
                        for: indexPath
                    ) as? HomeChampionCatogoryListTableViewCell else { return UITableViewCell() }
                    cell.bind(itemSize: .small, category, viewModel: viewModel)
                    return cell
                case .large(let category):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: HomeChampionCatogoryListTableViewCell.identifier,
                        for: indexPath
                    ) as? HomeChampionCatogoryListTableViewCell else { return UITableViewCell() }
                    cell.bind(itemSize: .large, category, viewModel: viewModel)
                    return cell
                }
            }
            .disposed(by: disposeBag)

        Observable.merge(
            viewModel.getHomeBannerButtonTapWithChampionID(),
            viewModel.getCategoryButtonTapWithChampionID()
        )
        .bind(onNext: { [weak self] id in
            self?.pushChampionDetailViewController(id: id)
        })
        .disposed(by: disposeBag)

        viewModel.getBetweenBannerButtonTapWithWebURL()
            .bind(onNext: { [weak self] webURL in
                self?.presentWebViewController(webURL: webURL)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController {
    func pushChampionDetailViewController(id: String) {
        print("Champion ID: \(id)")
    }

    func presentWebViewController(webURL: String?) {
        print("Present Web View: \(webURL)")
    }
}
