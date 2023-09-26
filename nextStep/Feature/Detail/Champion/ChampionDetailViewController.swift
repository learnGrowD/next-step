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
        skinListView.backgroundColor = .systemBlue
        tableView.backgroundColor = .clear

        tableView.register(
            ChampionDetailBlurTableViewCell.self,
            forCellReuseIdentifier: ChampionDetailBlurTableViewCell.identifier
        )
        tableView.register(
            ChampionDetailDescriptionTableViewCell.self,
            forCellReuseIdentifier: ChampionDetailDescriptionTableViewCell.identifier
        )
    }

    override func layout() {
        super.layout()
        view.addSubViews(informationView, skinListView)
        informationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        skinListView.snp.makeConstraints {
            $0.top.equalTo(informationView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
    }

    override func bind(_ viewModel: ChampionDetailViewModel) {
        super.bind(viewModel)

        viewModel.getLayoutStatusList()
            .bind(to: tableView.rx.items) { tableView, row, layoutStatus in
                switch layoutStatus {
                case .blur:
                    let indexPath = IndexPath(row: row, section: 0)
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: ChampionDetailBlurTableViewCell.identifier,
                        for: indexPath
                    ) as? ChampionDetailBlurTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.bind(viewModel)
                    return cell
                case .description:
                    let indexPath = IndexPath(row: row, section: 0)
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: ChampionDetailDescriptionTableViewCell.identifier,
                        for: indexPath
                    ) as? ChampionDetailDescriptionTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.bind(viewModel)
                    return cell
                case .skill:
                    return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)
    }
}

