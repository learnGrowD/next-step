//
//  CommonReactive+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: UICollectionView {
    func reloadData<T: Collection>() -> Binder<T> {
        Binder(base) { collectionView, data in
            if !data.isEmpty {
                collectionView.reloadData()
            }
        }
    }
}

extension Reactive where Base: UIImageView {
    var imageURLString: Binder<String> {
        Binder(base) { imageView, data in
            base.kf.setImage(with: URL(string: data))
        }
    }

    var imageURL: Binder<URL?> {
        Binder(base) { imageView, data in
            base.kf.setImage(with: data)
        }
    }
}

