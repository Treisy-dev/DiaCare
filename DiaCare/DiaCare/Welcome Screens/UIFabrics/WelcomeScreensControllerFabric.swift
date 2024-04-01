//
//  WelcomeScreensControllerFabric.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//

import Foundation
import UIKit

protocol WelcomeScreensControllerFabricProtocol {
    func makeMainAppTabBarController() -> UIViewController
    func makeInsulinConfigVC() -> UIViewController
    func makeFoodConfigVC() -> UIViewController
    func makeSugarConfigVC() -> UIViewController
}

final class WelcomeScreensControllerFabric: WelcomeScreensControllerFabricProtocol {

    let userDefaultsDataManager: UserDefaultsDataManagerProtocol
    let coreDataManager: CoreDataManagerProtocol

    init(userDefaultsDM: UserDefaultsDataManagerProtocol, coreDM: CoreDataManagerProtocol) {
        userDefaultsDataManager = userDefaultsDM
        coreDataManager = coreDM
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
            viewController: ProfileViewController(viewModel: ProfileViewModel(userDefaultsDM: userDefaultsDataManager)),
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
        let viewModel = InsulinConfigViewModel(coreDM: coreDataManager, userDefaultsDM: userDefaultsDataManager, welcomeScreenControllerFabric: self)
        return InsulinConfigViewController(viewModel: viewModel)
    }

    func makeFoodConfigVC() -> UIViewController {
        let viewModel = FoodConfigViewModel(userDefaultsDM: userDefaultsDataManager, welcomeScreenControllerFabric: self)
        return FoodConfigViewController(viewModel: viewModel)
    }

    func makeSugarConfigVC() -> UIViewController {
        let viewModel = SugarConfigViewModel(userDefaultsDM: userDefaultsDataManager, welcomeScreenControllerFabric: self)
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
