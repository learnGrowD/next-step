//
//  Font+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

extension UIFont {
    enum NestStepSize: CGFloat {
        case extraLarge = 32
        case large = 24
        case medium = 20
        case small = 16
        case extraSmall = 12
    }
    class func nestStepRegular(size: NestStepSize) -> UIFont? {
        R.font.notoSansRegular(size: size.rawValue)
    }

    class func nestStepBold(size: NestStepSize) -> UIFont? {
        R.font.notoSansSemiBold(size: size.rawValue)
    }
}
