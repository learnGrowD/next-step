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
        let blurView = UIView()
        blurView.backgroundColor = .darkGray
        self.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        kf.setImage(with: URL(string: imageURL)) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                blurView.alpha = 0.0
            }, completion: { _ in
                blurView.removeFromSuperview()
            })
        }
    }
}

extension UIImage {

}
