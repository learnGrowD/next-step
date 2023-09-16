//
//  BasePanModalPresentable.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import Foundation
import PanModal

protocol BasePanModalPresentable: PanModalPresentable {}
extension BasePanModalPresentable {
    var showDragIndicator: Bool {
        return false
    }

    var springDamping: CGFloat {
        return 1.0
    }

    var topOffset: CGFloat {
        return 0.0
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeight
    }

    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    var anchorModalToLongForm: Bool {
        return false
    }
}
