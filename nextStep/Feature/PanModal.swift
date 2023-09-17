//
//  PanModal.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import Foundation
import PanModal

final class PanModal: BaseViewController<BaseViewModel>, BasePanModalPresentable {



    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) {
        let topOffset = view.anchorPoint.y

        print("Top Offset: \(topOffset)")
    }

//    let panGestureRecognizer = UIPanGestureRecognizer(target: PanModal.self, action: #selector(handlePanGesture(_:)))
//
//
    override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBlue

    }
//
//    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
//        let translation = gestureRecognizer.translation(in: view)
//        print("Translation: \(translation)")
//
//        // translation 변수에는 CGPoint 형식의 변위가 저장됩니다.
//        // translation.x와 translation.y를 사용하여 가로 및 세로 이동 거리를 가져올 수 있습니다.
//
//        // 이후 원하는 동작을 수행합니다.
//    }

}
