//
//  WelcomeFlowCoordinator.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import Swinject
import UIKit

class WelcomeFlowCoordinator: Coordinator {

    let moduleFactory: WelcomeModuleFactoryProtocol

    var navigationController: UINavigationController

    init(moduleFactory: WelcomeModuleFactoryProtocol, navigationController: UINavigationController) {
        self.moduleFactory = moduleFactory
        self.navigationController = navigationController
    }

    func start() {
        guard let viewController = moduleFactory.createNameRegisterViewController() as? NameRegisterViewController else { return }

        navigationController = UINavigationController(rootViewController: viewController)
        viewController.onFinish = {
            self.showSugarConfigScreen()
        }
    }

    private func showSugarConfigScreen() {
        guard let viewController = moduleFactory.createSugarConfigViewController() as? SugarConfigViewController else { return }

        viewController.onFinish = { [weak self] in
            self?.showFoodConfigScreen()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showFoodConfigScreen() {
        guard let viewController = moduleFactory.createFoodConfigViewController() as? FoodConfigViewController else { return }

        viewController.onFinish = { [weak self] in
            self?.showInsulinConfigScreen()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showInsulinConfigScreen() {
        guard let viewController = moduleFactory.createInsulinCOnfigView() as? InsulinConfigViewController else { return }

        viewController.onFinish = { [weak self] in
            self?.showMainScreens()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showMainScreens() {
        let tbController = moduleFactory.createMainAppTabBar()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tbController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
