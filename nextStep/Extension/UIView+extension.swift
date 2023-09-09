//
//  UIView+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit

extension UIView {
    func snapshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func removeAllSubView() {
        for subView in subviews {
            subView.removeAllSubView()
        }
    }

    func addSubViews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }

    func debugBouns() {
        #if DEBUG
        layer.borderColor = UIColor.magenta.cgColor
        layer.borderWidth = 1
        #endif
    }
}
