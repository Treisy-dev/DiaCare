//
//  TemplateScreenFlowCoordinaor.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import UIKit
import Swinject

final class TemplateScreenFlowCoordinator {
    var navigationController: UINavigationController
    let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        guard let viewModel = container.resolve(TemplateViewModelProtocol.self) else { return }
        let viewController = TemplateViewController(viewModel: viewModel)
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.listIcon.resizeImage(newSize: CGSize(width: 30, height: 30)),
            selectedImage: nil)
        viewController.tabBarItem = templateTabBarItem
        viewController.addNewTemplate = {
            self.showNewTemplateScreen()
        }
        navigationController = UINavigationController(rootViewController: viewController)
    }

    private func showNewTemplateScreen() {
        guard let viewModel = container.resolve(NewTemplateViewModelProtocol.self) else { return }
        let viewController = NewTemplateViewController(viewModel: viewModel)

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        viewController.addProductTapped = { [weak self] in
            self?.showProductScreen()
        }
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showProductScreen() {
        guard let viewModel = container.resolve(ProductViewModelProtocol.self) else { return }
        let viewController = ProductViewController(viewModel: viewModel)

        viewController.productTapped = { [weak self] productName, productProps in
            self?.showProductConfigScreen(productName: productName, productProps: productProps)
        }

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        viewController.onFinishWithProducts = { [weak self] userProducts in
            self?.navigationController.popViewController(animated: true)
            guard let previousVC = self?.navigationController.topViewController as? NewTemplateViewController else { return }
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
        guard let viewModel = container.resolve(NewUserProductViewModelProtocol.self) else { return }
        let viewController = NewUserProductViewController(viewModel: viewModel)

        viewController.onFinish = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(viewController, animated: true)
    }

    private func showProductConfigScreen(productName: String, productProps: (String, String, String)) {
        guard let viewModel = container.resolve(ProductConfigViewModelProtocol.self) else { return }
        let viewController = ProfuctConfigViewController(viewModel: viewModel, productName: productName, productProps: productProps)

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
