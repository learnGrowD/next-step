//
//  BaseUIView.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit

class BaseUIView: UIView, BaseViewProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attribute() {}

    func layout() {}
}
