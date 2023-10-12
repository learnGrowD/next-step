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
    private lazy var bannerView = HomeBannerView(viewModel: viewModel)

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 88, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(HomeBetweenBannerTableViewCell.self,
                           forCellReuseIdentifier: HomeBetweenBannerTableViewCell.identifier)
        tableView.register(HomeChampionCatogoryListTableViewCell.self,
                           forCellReuseIdentifier: HomeChampionCatogoryListTableViewCell.identifier)
    }
    
    override func layout() {
        super.layout()
        view.addSubview(tableView)
        
        tableView.tableHeaderView = bannerView
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    override func bind(_ viewModel: HomeViewModel) {
        super.bind(viewModel)
        tableView.rx.contentOffset
            .map { 144 < $0.y }
            .bind(to: tableView.rx.bounces)
            .disposed(by: disposeBag)

        viewModel.gethomeLayoutStatusList()
            .bind(to: tableView.rx.items) { tableView, row, category in
                let indexPath = IndexPath(row: row, section: 0)
                switch category {
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
        .bind(onNext: { [weak self] championID in
            self?.pushChampionDetailViewController(championID: championID)
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
    func pushChampionDetailViewController(championID: String) {
        let championDetailViewModel = ChampionDetailViewModel(championID: championID)
        let championDetailViewController = ChampionDetailViewController(viewModel: championDetailViewModel)
        championDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(championDetailViewController, animated: true)
    }

    func presentWebViewController(webURL: String?) {
        guard let webURL = webURL else {
            CommonToast.Builder()
                .setMessage(message: "URL 경로가 잘못되었습니다.")
                .build(status: .bottom)
                .show()
            return
        }
        let webContext = WebContext(title: "velog", link: webURL)
        let commonWebViewModel = CommonWebViewModel(webContext: webContext)
        let commonWebViewController = CommonWebViewController(viewModel: commonWebViewModel)
        commonWebViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(commonWebViewController, animated: true)
    }
}
