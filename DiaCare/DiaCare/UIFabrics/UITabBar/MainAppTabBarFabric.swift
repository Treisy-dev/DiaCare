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
        let newNoteFlowCoordinator = NewNoteScreenFlowCoordinator(moduleFactory: mainAppModuleFactory, navigationController: UINavigationController())
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

        return tbController
    }
//    private func configTabBarItem(viewController: UIViewController, image: UIImage) -> UIViewController {
//        let templateTabBarItem = UITabBarItem(
//            title: nil,
//            image: image.resizeImage(newSize: CGSize(width: 30, height: 30)),
//            selectedImage: nil
//        )
//        viewController.tabBarItem = templateTabBarItem
//
//        return viewController
//    }
}
