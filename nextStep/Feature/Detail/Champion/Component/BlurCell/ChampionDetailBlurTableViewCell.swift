//
//  ChampionDetailBlurTableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ChampionDetailBlurTableViewCell: UITableViewCell {
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    private func layout() {
        contentView.snp.makeConstraints {
            $0.height.equalTo(56 + 16 + 324 + 32)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    func bind(_ viewModel: ChampionDetailViewModel) {
        contentView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                print("BlurView Buttontap")
            })
            .disposed(by: prepareDisposeBag)
    }
}
