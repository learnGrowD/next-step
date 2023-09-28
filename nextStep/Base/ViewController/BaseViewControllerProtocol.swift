//
//  BaseViewControllerProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

protocol BaseViewControllerProtocol: UIViewController {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel { get set }
    func bind(_ viewModel: ViewModel)
    func attribute()
    func layout()
}

extension BaseViewControllerProtocol {
    func mInit() {
        viewModel.lifeCycleStatus.accept(.mInit)
        print("🍎 init: \(className)")
    }

    func mViewDidLoad() {
        acceptJudgeViewController(value: self)
        attribute()
        layout()
        bind(viewModel)
        viewModel.lifeCycleStatus.accept(.viewDidLoad)
        print("🍎 viewDidLoad: \(className)")
    }
    func mViewWillAppear(_ animated: Bool) {
        acceptJudgeViewController(value: self)

        viewModel.lifeCycleStatus.accept(.viewWillAppear)
        print("🍎 viewWillAppear: \(className)")
    }
    func mViewDidAppear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidAppear)
        print("🍎 viewDidAppear: \(className)")
    }
    func mViewWillLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewWillLayoutSubviews)
        print("🍎 viewWillLayoutSubviews: \(className)")
    }
    func mViewDidLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewDidLayoutSubviews)
        print("🍎 viewDidLayoutSubviews: \(className)")
    }
    func mViewWillDisappear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewWillDisAppear)
        print("🍎 viewWillDisappear: \(className)")
    }
    func mViewDidDisappear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidDisAppear)
        print("🍎 viewDidDisappear: \(className)")
    }
    func mDeinit() {
        viewModel.lifeCycleStatus.accept(.mDeinit)
        print("🍎 ViewController deinit: \(className)")
    }
}

extension BaseViewControllerProtocol {
    func acceptJudgeViewController(value: UIViewController?) {
        //XLPager의 자식이 아닌 다른 ViewController에서는 depthViewController를 업데이트 시켜준다.
        guard !(self is CommonBottomModal) else { return }
        guard !(self is CommonModal) else { return }
        guard !(self is UIViewController & IndicatorInfoProvider) else { return }
        appContext?.judgeViewController.accept(value)
        print("🧊 accept depthViewController: \(String(describing: value.self))")
    }
}


