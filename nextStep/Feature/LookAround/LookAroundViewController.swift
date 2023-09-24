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
        
    }
    override func layout() {
        super.layout()
        view.addSubViews(categoryView, tableView)
        categoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    override func bind(_ viewModel: LookAroundViewModel) {
        super.bind(viewModel)
        viewModel.getCategoryButtonTapWithCategoryStatus()
            .bind(onNext: { [weak self] status in
                self?.scrollToCategory(categoryStatus: status)
            })
            .disposed(by: disposeBag)
    }
}

extension LookAroundViewController {
    private func scrollToCategory(categoryStatus: LookAroundCategoryStatus) {
        print("category Status: \(categoryStatus)")
    }
}
