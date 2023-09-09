//
//  BaseViewControllerLifeCycleStatus.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

enum BaseViewControllerLifeCycleStatus {
    case notInit
    case mInit
    case viewDidLoad
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case viewWillAppear
    case viewDidAppear
    case viewWillDisAppear
    case viewDidDisAppear
    case mDeinit
}
