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

    let container: Container

    init(container: Container) {
        self.container = container
    }

    func makeMainAppTabBarController() -> UIViewController {
        let tbController: UITabBarController = UITabBarController()
        tbController.tabBar.tintColor = .mainApp
        tbController.tabBar.backgroundColor = .white

        let templateFlowCoordinator = TemplateScreenFlowCoordinator(container: container, navigationController: UINavigationController())
        templateFlowCoordinator.start()

        let statisticViewController = configTabBarItem(
            viewController: StatisticViewController(),
            image: UIImage.chartIcon)

        let newNoteFlowCoordinator = NewNoteScreenFlowCoordinator(container: container, navigationController: UINavigationController())
        newNoteFlowCoordinator.start()

        let notificationViewController = configTabBarItem(
            viewController: NotificationViewController(),
            image: UIImage.bellIcon)

        guard let profileVM = container.resolve(ProfileViewModelProtocol.self) else { return tbController}
        let profileViewController = configTabBarItem(
            viewController: ProfileViewController(viewModel: profileVM),
            image: UIImage.profileIcon)

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

    private func configTabBarItem(viewController: UIViewController, image: UIImage) -> UIViewController {
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: image.resizeImage(newSize: CGSize(width: 30, height: 30)),
            selectedImage: nil)
        viewController.tabBarItem = templateTabBarItem

        return viewController
    }
}
