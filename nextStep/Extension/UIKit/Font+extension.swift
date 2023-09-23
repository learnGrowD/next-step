//
//  Font+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

extension UIFont {
    class func nestStepRegular(size: NestStepSize) -> UIFont? {
        R.font.notoSansRegular(size: size.rawValue)
    }

    class func nestStepBold(size: NestStepSize) -> UIFont? {
        R.font.notoSansSemiBold(size: size.rawValue)
    }
}


