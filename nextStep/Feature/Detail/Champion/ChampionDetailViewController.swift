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
    private lazy var informationView = ChampionDetailInformationView(viewModel: viewModel)
    private lazy var skinListView = ChampionDetailSkinListView(viewModel: viewModel)
    private let tableView = UITableView()

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        informationView.backgroundColor = .systemRed
        skinListView.backgroundColor = .systemBlue
        tableView.backgroundColor = .clear
    }

    override func layout() {
        super.layout()
        view.addSubViews(informationView, skinListView, tableView)
        informationView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        skinListView.snp.makeConstraints {
            $0.height.equalTo(416)
            $0.top.equalTo(informationView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: ChampionDetailViewModel) {
        super.bind(viewModel)
    }
}

