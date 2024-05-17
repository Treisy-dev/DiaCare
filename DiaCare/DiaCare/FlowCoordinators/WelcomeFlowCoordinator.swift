//
//  WelcomeFlowCoordinator.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import Swinject
import UIKit

class WelcomeFlowCoordinator: Coordinator {
    
    let container: Container

    var navigationController: UINavigationController

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        guard let viewModel = container.resolve(NameRegisterViewModelProtocol.self) else { return }
        let viewController = NameRegisterViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        viewController.onFinish = {
            self.showSugarConfigScreen()
        }
    }

    private func showSugarConfigScreen() {
        guard let viewModel = container.resolve(SugarConfigViewModelProtocol.self) else { return }
        let viewController = SugarConfigViewController(viewModel: viewModel)
        viewController.onFinish = { [weak self] in
            self?.showFoodConfigScreen()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showFoodConfigScreen() {
        guard let viewModel = container.resolve(FoodConfigViewModelProtocol.self) else { return }
        let viewController = FoodConfigViewController(viewModel: viewModel)
        viewController.onFinish = { [weak self] in
            self?.showInsulinConfigScreen()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showInsulinConfigScreen() {
        guard let viewModel = container.resolve(InsulinConfigViewModelProtocol.self) else { return }
        let viewController = InsulinConfigViewController(viewModel: viewModel)
        viewController.onFinish = { [weak self] in
            self?.showMainScreens()
        }
        viewController.onBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showMainScreens() {
        guard let mainAppTabBarFabric = container.resolve(MainAppTabBarFabricProtocol.self) else { return }
        let tbController = mainAppTabBarFabric.makeMainAppTabBarController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tbController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
