//
//  ProductScreenFlowCoordinator.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import Swinject
import UIKit

final class NewNoteScreenFlowCoordinator: Coordinator {

    let moduleFactory: MainAppModuleFactoryProtocol

    var navigationController: UINavigationController

    init(moduleFactory: MainAppModuleFactoryProtocol, navigationController: UINavigationController) {
        self.moduleFactory = moduleFactory
        self.navigationController = navigationController
    }

    func start() {
        guard let viewController = moduleFactory.createNewNoteViewController() as? NewNoteViewController else { return }

        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.circledPlusIcon.resizeImage(newSize: CGSize(width: 30, height: 30)),
            selectedImage: nil)
        viewController.tabBarItem = templateTabBarItem
        navigationController = UINavigationController(rootViewController: viewController)
        viewController.onFinish = {
            self.showProductScreen()
        }
    }

    private func showProductScreen() {
        guard let viewController = moduleFactory.createProductViewController() as? ProductViewController else { return }

        viewController.productTapped = { [weak self] productName, productProps in
            self?.showProductConfigScreen(productName: productName, productProps: productProps)
        }

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        viewController.onFinishWithProducts = { [weak self] userProducts in
            self?.navigationController.popViewController(animated: true)
            guard let previousVC = self?.navigationController.topViewController as? NewNoteViewController else { return }
            for product in userProducts {
                previousVC.viewModel.userProducts.append(product)
            }
        }

        viewController.addUserProductTapped = { [weak self] in
            self?.showNewUserProductScreen()
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showNewUserProductScreen() {
        guard let viewController = moduleFactory.createNewUserProductViewController() as? NewUserProductViewController else { return }

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showProductConfigScreen(productName: String, productProps: (String, String, String)) {
        guard let viewController = moduleFactory.createProductConfigViewController(
            productName: productName,
            productProps: productProps
        ) as? ProfuctConfigViewController else { return }

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        viewController.onFinishWithProduct = { [weak self] userProduct in
            self?.navigationController.popViewController(animated: true)
            guard let previousVC = self?.navigationController.topViewController as? ProductViewController else { return }
            previousVC.viewModel.usersProduct.append(userProduct)
        }

        navigationController.pushViewController(viewController, animated: true)
    }
}
