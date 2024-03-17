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

        let templateViewController = TemplateViewController()
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.listIcon,
            selectedImage: nil)
        templateViewController.tabBarItem = templateTabBarItem

        let statisticViewController = StatisticViewController()
        let statisticTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.chartIcon,
            selectedImage: nil)
        statisticViewController.tabBarItem = statisticTabBarItem

        let newNoteViewController = NewNoteViewController(viewModel: NewNoteViewModel())
        let newNoteTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.circledPlusIcon,
            selectedImage: nil)
        newNoteViewController.tabBarItem = newNoteTabBarItem

        let notificationViewController = NotificationViewController()
        let notificationTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.bellIcon,
            selectedImage: nil)
        notificationViewController.tabBarItem = notificationTabBarItem

        let profileViewController = ProfileViewController(viewModel: ProfileViewModel())
        let profileTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.profileIcon,
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

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
}
