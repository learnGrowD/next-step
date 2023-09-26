//
//  ChampionDetailDescriptionTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailDescriptionTableViewCell: UITableViewCell {
    private var prepareDisposeBag = DisposeBag()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        prepareDisposeBag = DisposeBag()
    }

    private func attribute() {
        contentView.backgroundColor = .systemRed
    }

    private func layout() {

    }

    func bind(_ viewModel: ChampionDetailViewModel) {
        contentView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("description Buttontap")
            })
            .disposed(by: prepareDisposeBag)
    }
    
}
