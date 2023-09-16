//
//  CommonEmptyLabel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonEmptyView<T: Collection>: UIView {
    private let disposeBag = DisposeBag()
    private let list: Observable<T>

    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()

    override var intrinsicContentSize: CGSize {
        let width = emptyLabel.intrinsicContentSize.width
        let imageViewHeight: CGFloat = 44
        let height = 16 + imageViewHeight + 8 + emptyLabel.intrinsicContentSize.height + 16

        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, list: Observable<T>) {
        self.list = list
        super.init(frame: frame)
        attribute()
        layout()
        bind()
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setEmptyName(name: String) {
        emptyLabel.text = name
    }

    private func bind() {
        list
            .map { !$0.isEmpty }
            .bind(to: self.rx.isHidden)
            .disposed(by: disposeBag)
    }

    private func attribute() {
        emptyImageView.image = UIImage(systemName: "pencil.circle.fill")
        emptyImageView.contentMode = .scaleAspectFill

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.textColor = .systemGray3
        emptyLabel.numberOfLines = 1
    }

    private func layout() {
        [
            emptyImageView,
            emptyLabel
        ].forEach {
            addSubview($0)
        }

        emptyImageView.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
