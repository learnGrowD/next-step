//
//  CommonToast.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/10.
//

import UIKit
/*
 3가지 타입을 정의할것이다.
 첫째는 아래에서 나오는 Toast
 둘쨰는 가운데
 셋째는 위에서 나오는 Toast
 */

enum CommonToastPosionStatus {
    case top
    case center
    case bottom
}
struct CommonToastCreateContext {
    let position: CommonToastPosionStatus
    let message: String
    let onClickDelegate: (UIView) -> Void
}

class CommonToastBuilder {
    private let context: CommonToastCreateContext
    init(context: CommonToastCreateContext) {
        self.context = context
    }

    func build() -> CommonToastProtocol {
        switch context.position {
        case .top:
            return TopCommonToast.Builder()
                .setMessage(message: context.message)
                .setOnClickDelegate(delegate: context.onClickDelegate)
                .build()
        case .center:
            return CenterCommonToast.Builder()
                .setMessage(message: context.message)
                .setOnClickDelegate(delegate: context.onClickDelegate)
                .build()
        case .bottom:
            return BottomCommonToast.Builder()
                .setMessage(message: context.message)
                .setOnClickDelegate(delegate: context.onClickDelegate)
                .build()
        }
    }
}

protocol CommonToastProtocol {
    func show()
}

private class CommonToast: UIView, CommonToastProtocol {
    func show() {
        let context = CommonToastCreateContext(position: .bottom, message: "HELLO") { _ in

        }
        CommonToastBuilder(context: context)
            .build()
            .show()
    }
}

//MARK: - top
private final class TopCommonToast: CommonToast {

    final class Builder {

        private var message: String = ""

        private var onClickDelegate: (CommonToast) -> Void = { _ in }

        func setMessage(message: String) -> Self {
            self.message = message
            return self
        }

        func setOnClickDelegate(delegate: @escaping (CommonToast) -> Void) -> Self {
            self.onClickDelegate = delegate
            return self
        }

        func build() -> CommonToast {
            TopCommonToast()
        }
    }
}
//MARK: - center
private final class CenterCommonToast: CommonToast {



    final class Builder {
        private var message: String = ""

        private var onClickDelegate: (CommonToast) -> Void = { _ in }

        func setMessage(message: String) -> Self {
            return self
        }

        func setOnClickDelegate(delegate: @escaping (CommonToast) -> Void) -> Self {
            return self
        }

        func build() -> CommonToast {
            CenterCommonToast()
        }
    }
}

//MARK: - bottom
private final class BottomCommonToast: CommonToast {



    final class Builder {
        private var message: String = ""

        private var onClickDelegate: (CommonToast) -> Void = { _ in }

        func setMessage(message: String) -> Self {
            return self
        }

        func setOnClickDelegate(delegate: @escaping (CommonToast) -> Void) -> Self {
            return self
        }

        func build() -> CommonToast {
            BottomCommonToast()
        }
    }
}
