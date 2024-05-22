//
//  WelcomeScreensControllerFabric.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//

import Swinject
import UIKit

protocol MainAppTabBarFabricProtocol {
    func makeMainAppTabBarController() -> UIViewController
}

final class MainAppTabBarFabric: MainAppTabBarFabricProtocol {

    let mainAppModuleFactory: MainAppModuleFactoryProtocol
    let tabBarModuleFactory: TabBarModuleFactoryProtocol

    init(mainAppModuleFactory: MainAppModuleFactoryProtocol, tabBarModuleFactory: TabBarModuleFactoryProtocol) {
        self.mainAppModuleFactory = mainAppModuleFactory
        self.tabBarModuleFactory = tabBarModuleFactory
    }

    func makeMainAppTabBarController() -> UIViewController {
        let tbController: UITabBarController = UITabBarController()
        tbController.tabBar.tintColor = .mainApp
        tbController.tabBar.backgroundColor = .white

        let templateFlowCoordinator = TemplateScreenFlowCoordinator(
            moduleFactory: mainAppModuleFactory,
            navigationController: UINavigationController()
        )
        templateFlowCoordinator.start()
        let newNoteFlowCoordinator = NewNoteScreenFlowCoordinator(
            moduleFactory: mainAppModuleFactory,
            navigationController: UINavigationController()
        )
        newNoteFlowCoordinator.start()
        let statisticViewController = tabBarModuleFactory.createStatisticViewController()
        let notificationViewController = tabBarModuleFactory.createNotificationViewController()
        let profileViewController = tabBarModuleFactory.createProfileViewController()

        tbController.viewControllers = [
            templateFlowCoordinator.navigationController,
            UINavigationController(rootViewController: statisticViewController),
            newNoteFlowCoordinator.navigationController,
            UINavigationController(rootViewController: notificationViewController),
            UINavigationController(rootViewController: profileViewController)
            ]
        tbController.selectedIndex = 4

        for item in tbController.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        }

        return tbController
    }
}
