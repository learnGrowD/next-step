//
//  GalleryViewController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/17.
//

import UIKit
import PanModal

final class GalleryViewController: BaseViewController<GalleryViewModel> {
    private let titleNavigationLabel = UILabel()
    private let tableView = UITableView()
    private lazy var headerView = GalleryHeaderView(viewModel: viewModel)

    override func attribute() {
        super.attribute()
        view.backgroundColor = R.color.nestStepBlack()
        titleNavigationLabel.font = .nestStepBold(size: .large)
        titleNavigationLabel.text = R.string.localizable.galleryTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleNavigationLabel)
        tableView.register(
            GalleyInformationTableViewCell.self,
            forCellReuseIdentifier: GalleyInformationTableViewCell.identifier
        )
    }
    
    override func layout() {
        super.layout()
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: GalleryViewModel) {
        super.bind(viewModel)
        viewModel.getGalleyInformationList()
            .bind(to: tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: GalleyInformationTableViewCell.identifier,
                    for: indexPath) as? GalleyInformationTableViewCell else { return UITableViewCell() }
                cell.bind(data: data, viewModel: viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.getInformationButtonTapWithAttributeData()
            .bind(onNext: { [weak self] data in
                self?.translateLink(data: data)
            })
            .disposed(by: disposeBag)
    }
}

extension GalleryViewController {
    private func translateLink(data: GalleryInformationAttribute) {
        switch data.informationStatus {
        case .phone:
            translateCall(link: data.link)
        case .web:
            translateWebPage(link: data.link)
        }
    }

    private func translateCall(link: String) {
        let phoneLink = link.replacingOccurrences(of: "-", with: "")
        if let url = URL(string: "tel://\(phoneLink)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    private func translateWebPage(link: String) {

    }
}
