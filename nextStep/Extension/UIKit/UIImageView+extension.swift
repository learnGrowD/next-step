//
//  UIImageView+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    func bindImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        kf.setImage(with: URL(string: imageURL))
    }
}

extension UIImage {

}
