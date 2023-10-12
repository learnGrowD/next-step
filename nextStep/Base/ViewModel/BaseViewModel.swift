//
//  BaseViewModel.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()

    //ovverride에 의해서 Observer가 모두 세팅이 되었을때 lifeCycleStatus가 갱신
    let lifeCycleStatus = BehaviorRelay<BaseViewControllerLifeCycleStatus>(value: .notInit)

    deinit {
        print("🍎 ViewModel deinit: \(className)")
    }
}


