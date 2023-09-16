//
//  BaseUITableViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

class BaseUITableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

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
        disposeBag = DisposeBag()
    }

    /*
     ViewModel이 필요한 tableViewCell이면 bind를 사용
     */
    func bind<ViewModel: BaseViewModel, Data>(
        viewModel: ViewModel,
        data: Data) {
        setUI(data: data)
    }
    /*
     ViewModel이 필요 없는 tableViewCell이면 setUI 사용
     */
    func setUI<T>(data: T) {}

    func attribute() {
        self.selectionStyle = .none
    }

    func layout() {}
}
