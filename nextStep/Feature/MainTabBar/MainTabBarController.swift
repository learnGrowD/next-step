//
//  MainTabBarController.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import UIKit
import RxSwift
import RxCocoa

final class MainTabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func registerViewController(
        targetViewController: UIViewController,
        tabBarImageName: String,
        titleName: String) -> UIViewController {
            targetViewController.tabBarItem.image = UIImage(named: tabBarImageName)
            targetViewController.tabBarItem.title = titleName
            return targetViewController
        }

    private func attribute() {
        delegate = self
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)

        let lookAroundViewModel = LookAroundViewModel()
        let lookAroundViewController = LookAroundViewController(viewModel: lookAroundViewModel)

        let galleryViewModel = GalleryViewModel()
        let galleryViewController = GalleryViewController(viewModel: galleryViewModel)

        viewControllers = [
            registerViewController(targetViewController: homeViewController, tabBarImageName: "", titleName: "Home"),
            registerViewController(targetViewController: lookAroundViewController, tabBarImageName: "", titleName: "둘러보기"),
            registerViewController(targetViewController: galleryViewController, tabBarImageName: "", titleName: "갤러리")
        ]
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        let category = MainTapBarCategory.getCategory(index: index)

        switch category {
        case .home:
            break
        case .lookAround:
            break
        case .gallery:
            break
        }
        return true
    }
}
