//
//  StorageProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/16.
//

import UIKit

protocol StorageProtocol {}
extension UIView: StorageProtocol {}
extension UIViewController: StorageProtocol {}
extension StorageProtocol {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    var window: UIWindow? {
        sceneDelegate?.window
    }

    var rootViewController: UIViewController? {
        window?.rootViewController
    }
}
