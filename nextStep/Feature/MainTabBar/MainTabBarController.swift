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
    var homeViewController: HomeViewController?
    var lookAroundViewController: LookAroundViewController?
    var gallertViewController: GalleryViewController?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func registerViewController(category: MainTapBarCategory) -> UIViewController {
        var result: UIViewController?
        switch category {
        case .home:
            result = homeViewController == nil ? UIViewController() : homeViewController
        case .lookAround:
            result = lookAroundViewController == nil ? UIViewController() : lookAroundViewController
        case .gallery:
            result = gallertViewController == nil ? UIViewController() : gallertViewController
        }
        guard let result = result else { return UIViewController() }
        let resource = getTabBarResource(category: category)
        result.tabBarItem.image = UIImage(named: resource.tabBarImageName)
        result.tabBarItem.title = resource.titleName
        return result
    }

    private func createViewController(category: MainTapBarCategory) {
        switch category {
        case .home:
            if homeViewController == nil {
                let homeViewModel = HomeViewModel()
                homeViewController = HomeViewController(viewModel: homeViewModel)
            }
        case .lookAround:
            if lookAroundViewController == nil {
                let lookAroundViewModel = LookAroundViewModel()
                lookAroundViewController = LookAroundViewController(viewModel: lookAroundViewModel)
            }
        case .gallery:
            if gallertViewController == nil {
                let gallertViewModel = GalleryViewModel()
                gallertViewController = GalleryViewController(viewModel: gallertViewModel)
            }
        }
    }

    private func getTabBarResource(category: MainTapBarCategory) -> (tabBarImageName: String, titleName: String) {
        switch category {
        case .home:
            return ("", R.string.localizable.homeTabTitle())
        case .lookAround:
            return ("", R.string.localizable.lookAroundTabTitle())
        case .gallery:
            return ("", R.string.localizable.galleryTabTitle())
        }
    }

    let emptyView = UIViewController()
    private func attribute() {
        delegate = self
        createViewController(category: .home)
        /*
         동일한 주소를 가진 UIViewController를 register하면 tabBar에 적용이 안된다.
         다른주소의 emptyViewController를 넣어줘야 한다.
         */
        viewControllers = [
            registerViewController(category: .home),
            registerViewController(category: .lookAround),
            registerViewController(category: .gallery),
        ]
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        let category = MainTapBarCategory.getCategory(index: index)
        createViewController(category: category)
        viewControllers?[category.rawValue] = registerViewController(category: category)
    }
}
