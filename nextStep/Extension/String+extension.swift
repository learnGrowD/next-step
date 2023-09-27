//
//  String+extension.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/23.
//

import UIKit

extension String {
    func convertNumberWithZeros() -> String? {
        guard let number = Int(self) else { return "" }
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 4
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: number))
    }

    func getBoldWidthSize(size: NestStepSize) -> CGFloat {
        let tempLabel = UILabel()
        tempLabel.numberOfLines = 0
        tempLabel.text = self
        tempLabel.font = R.font.notoSansSemiBold(size: size.rawValue)
        return tempLabel.intrinsicContentSize.width
    }

    func getRegularWidthSize(size: NestStepSize, text: String) -> CGFloat {
        let tempLabel = UILabel()
        tempLabel.numberOfLines = 0
        tempLabel.text = text
        tempLabel.font = R.font.notoSansRegular(size: size.rawValue)
        return tempLabel.intrinsicContentSize.width
    }

    func getRegularHeightSize(size: NestStepSize, width: CGFloat, numberOfLines: Int = 0) -> CGFloat {
        let label = UILabel()
        label.font = .nestStepRegular(size: size)
        label.text = self
        label.numberOfLines = numberOfLines

        let labelSize = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return labelSize.height

    }

    func getBoldHeightSize(size: NestStepSize, width: CGFloat, numberOfLines: Int = 0) -> CGFloat {
        let label = UILabel()
        label.font = .nestStepBold(size: size)
        label.text = self
        label.numberOfLines = numberOfLines

        let labelSize = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return labelSize.height
    }
}
