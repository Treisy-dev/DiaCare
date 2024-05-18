//
//  WelcomeModuleFactory.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.05.2024.
//

import Swinject
import UIKit

protocol WelcomeModuleFactoryProtocol {
    func createMainAppTabBar() -> UIViewController
    func createNameRegisterViewController() -> UIViewController
    func createSugarConfigViewController() -> UIViewController
    func createFoodConfigViewController() -> UIViewController
    func createInsulinCOnfigView() -> UIViewController
}

final class WelcomeModuleFactory: WelcomeModuleFactoryProtocol {

    let container: Container

    init(container: Container) {
        self.container = container
    }

    func createMainAppTabBar() -> UIViewController {
        guard let mainAppTabBarFabric = container.resolve(MainAppTabBarFabricProtocol.self) else { return UIViewController() }
        return mainAppTabBarFabric.makeMainAppTabBarController()
    }

    func createNameRegisterViewController() -> UIViewController {
        guard let viewModel = container.resolve(NameRegisterViewModelProtocol.self) else { return UIViewController() }
        return NameRegisterViewController(viewModel: viewModel)
    }

    func createSugarConfigViewController() -> UIViewController {
        guard let viewModel = container.resolve(SugarConfigViewModelProtocol.self) else { return UIViewController() }
        return SugarConfigViewController(viewModel: viewModel)
    }

    func createFoodConfigViewController() -> UIViewController {
        guard let viewModel = container.resolve(FoodConfigViewModelProtocol.self) else { return UIViewController() }
        return FoodConfigViewController(viewModel: viewModel)
    }

    func createInsulinCOnfigView() -> UIViewController {
        guard let viewModel = container.resolve(InsulinConfigViewModelProtocol.self) else { return UIViewController() }
        return InsulinConfigViewController(viewModel: viewModel)
    }
}
