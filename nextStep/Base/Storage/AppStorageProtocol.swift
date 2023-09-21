//
//  AppStorageProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit
import XLPagerTabStrip

protocol AppStorageProtocol {}
extension UIView: AppStorageProtocol {}
extension UIViewController: AppStorageProtocol {}
extension BaseViewModel: AppStorageProtocol {}
extension AppStorageProtocol {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }

    var appContext: AppContext? {
        appDelegate?.appContext
    }

    var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    var window: UIWindow? {
        sceneDelegate?.window
    }

    var safeAreaTopInsets: CGFloat {
        window?.safeAreaInsets.top ?? 0.0
    }

    var rootViewController: UIViewController? {
        window?.rootViewController
    }

    var topMostViewController: UIViewController? {
        var topMostViewController = self.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        while let parentViewController = topMostViewController?.parent {
            if parentViewController is UINavigationController {
                topMostViewController = parentViewController
            }

            if let presentedViewController = parentViewController.presentedViewController,
                        presentedViewController != topMostViewController {
                topMostViewController = presentedViewController
            }
        }

        return topMostViewController
    }

    var depthViewController: UIViewController? {
        var depthViewController = appContext?.judgeViewController.value
        //UIViewController, TabBar는 큰 컨테이너 개념이기 때문에 Pass

        //XLPager 작은 container 개념으로 본다
        if let pagerViewController = depthViewController as? ButtonBarPagerTabStripViewController {
            depthViewController = pagerViewController
        }

        return depthViewController
    }
}
