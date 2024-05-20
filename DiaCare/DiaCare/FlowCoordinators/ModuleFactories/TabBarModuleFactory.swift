//
//  TabBarModuleFactory.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.05.2024.
//

import Swinject
import UIKit

protocol TabBarModuleFactoryProtocol {
    func createStatisticViewController() -> UIViewController
    func createNotificationViewController() -> UIViewController
    func createProfileViewController() -> UIViewController
}

final class TabBarModuleFactory: TabBarModuleFactoryProtocol {

    let container: Container

    init(container: Container) {
        self.container = container
    }

    func createStatisticViewController() -> UIViewController {
        guard let statisticViewModel = container.resolve(StatisticViewModelProtocol.self) else { return UIViewController() }
        return configTabBarItem(
            viewController: StatisticViewController(viewModel: statisticViewModel),
            image: UIImage.chartIcon
        )
    }

    func createNotificationViewController() -> UIViewController {
        guard let notificationViewModel = container.resolve(NotificationViewModelProtocol.self) else { return UIViewController() }
        return configTabBarItem(
            viewController: NotificationViewController(viewModel: notificationViewModel),
            image: UIImage.bellIcon
        )
    }

    func createProfileViewController() -> UIViewController {
        guard let profileVM = container.resolve(ProfileViewModelProtocol.self) else { return UIViewController() }
        return configTabBarItem(
            viewController: ProfileViewController(viewModel: profileVM),
            image: UIImage.profileIcon
        )
    }

    private func configTabBarItem(viewController: UIViewController, image: UIImage) -> UIViewController {
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: image.resizeImage(newSize: CGSize(width: 30, height: 30)),
            selectedImage: nil
        )
        viewController.tabBarItem = templateTabBarItem

        return viewController
    }
}
