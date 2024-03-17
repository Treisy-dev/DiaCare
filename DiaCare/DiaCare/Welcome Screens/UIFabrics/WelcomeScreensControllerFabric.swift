//
//  WelcomeScreensControllerFabric.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//

import Foundation
import UIKit

class WelcomeScreensControllerFabric {
    public static let shared = WelcomeScreensControllerFabric()

    private init() {
    }

    func makeMainAppTabBarController() -> UIViewController {
        let tbController: UITabBarController = UITabBarController()
        tbController.tabBar.tintColor = .mainApp
        tbController.tabBar.backgroundColor = .white

        let templateViewController = configTabBarItem(
            viewController: TemplateViewController(),
            image: UIImage.listIcon)
        let statisticViewController = configTabBarItem(
            viewController: StatisticViewController(),
            image: UIImage.chartIcon)
        let newNoteViewController = configTabBarItem(
            viewController: NewNoteViewController(viewModel: NewNoteViewModel()),
            image: UIImage.circledPlusIcon)
        let notificationViewController = configTabBarItem(
            viewController: NotificationViewController(),
            image: UIImage.bellIcon)
        let profileViewController = configTabBarItem(
            viewController: ProfileViewController(viewModel: ProfileViewModel()),
            image: UIImage.profileIcon)

        tbController.viewControllers = [
            UINavigationController(rootViewController: templateViewController),
            UINavigationController(rootViewController: statisticViewController),
            UINavigationController(rootViewController: newNoteViewController),
            UINavigationController(rootViewController: notificationViewController),
            UINavigationController(rootViewController: profileViewController)
            ]
        tbController.selectedIndex = 4

        return tbController
    }

    func makeInsulinConfigVC() -> UIViewController {
        let viewModel = InsulinConfigViewModel()
        return InsulinConfigViewController(viewModel: viewModel)
    }

    func makeFoodConfigVC() -> UIViewController {
        let viewModel = FoodConfigViewModel()
        return FoodConfigViewController(viewModel: viewModel)
    }

    func makeSugarConfigVC() -> UIViewController {
        let viewModel = SugarConfigViewModel()
        return SugarConfigViewController(viewModel: viewModel)
    }

    private func configTabBarItem(viewController: UIViewController, image: UIImage) -> UIViewController {
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: image.resizeImage(newSize: CGSize(width: 30, height: 30)),
            selectedImage: nil)
        viewController.tabBarItem = templateTabBarItem

        return viewController
    }
}
