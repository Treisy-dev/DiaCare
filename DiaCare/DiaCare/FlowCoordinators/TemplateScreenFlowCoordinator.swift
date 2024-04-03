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
        navigationController = UINavigationController(rootViewController: viewController)
    }
}
