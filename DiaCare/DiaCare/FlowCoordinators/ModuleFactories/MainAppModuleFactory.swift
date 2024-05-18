//
//  ModuleFactory.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.05.2024.
//

import Swinject
import UIKit

protocol MainAppModuleFactoryProtocol {
    func createTemplateViewController() -> UIViewController
    func createNewTemplateViewController() -> UIViewController
    func createProductViewController() -> UIViewController
    func createNewUserProductViewController() -> UIViewController
    func createProductConfigViewController(productName: String, productProps: (String, String, String)) -> UIViewController
    func createNewNoteViewController() -> UIViewController
}

final class MainAppModuleFactory: MainAppModuleFactoryProtocol {

    let container: Container

    init(container: Container) {
        self.container = container
    }

    func createTemplateViewController() -> UIViewController {
        guard let viewModel = container.resolve(TemplateViewModelProtocol.self) else { return UIViewController() }
        return TemplateViewController(viewModel: viewModel)
    }

    func createNewTemplateViewController() -> UIViewController {
        guard let viewModel = container.resolve(NewTemplateViewModelProtocol.self) else { return UIViewController() }
        return NewTemplateViewController(viewModel: viewModel)
    }

    func createProductViewController() -> UIViewController {
        guard let viewModel = container.resolve(ProductViewModelProtocol.self) else { return UIViewController() }
        return ProductViewController(viewModel: viewModel)
    }

    func createNewUserProductViewController() -> UIViewController {
        guard let viewModel = container.resolve(NewUserProductViewModelProtocol.self) else { return UIViewController() }
        return NewUserProductViewController(viewModel: viewModel)
    }

    func createProductConfigViewController(productName: String, productProps: (String, String, String)) -> UIViewController {
        guard let viewModel = container.resolve(ProductConfigViewModelProtocol.self) else { return UIViewController() }
        return ProfuctConfigViewController(viewModel: viewModel, productName: productName, productProps: productProps)
    }

    func createNewNoteViewController() -> UIViewController {
        guard let viewModel = container.resolve(NewNoteViewModelProtocol.self) else { return UIViewController() }
        return NewNoteViewController(viewModel: viewModel)
    }
}
