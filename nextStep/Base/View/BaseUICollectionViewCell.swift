//
//  BaseUICollectionViewCell.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

class BaseUICollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
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

    func setUI<T>(data: T) {}

    func attribute() {}

    func layout() {}
}
