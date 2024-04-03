//
//  ProductScreenFlowCoordinator.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import Swinject
import UIKit

final class NewNoteScreenFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        guard let viewModel = container.resolve(NewNoteViewModelProtocol.self) else { return }
        let viewController = NewNoteViewController(viewModel: viewModel)
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
        guard let viewModel = container.resolve(ProductViewModelProtocol.self) else { return }
        let viewController = ProductViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }
}
