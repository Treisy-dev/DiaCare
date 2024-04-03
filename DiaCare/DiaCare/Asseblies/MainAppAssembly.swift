//
//  ServiceLocator.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 02.04.2024.
//

import Swinject

final class MainAppAssembly: Assembly {
    func assemble(container: Swinject.Container) {

        // MARK: - Services
        container.register(TranslationNetworkServiceProtocol.self) { _ in
            TranslationNetworkService()
        }
        .inObjectScope(.container)

        container.register(ProductNetworkServiceProtocol.self) { _ in
            ProductNetworkService()
        }
        .inObjectScope(.container)

        container.register(CoreDataManagerProtocol.self) { _ in
            CoreDataManager()
        }
        .inObjectScope(.container)

        container.register(UserDefaultsDataManagerProtocol.self) { _ in
            UserDefaultsDataManager()
        }
        .inObjectScope(.weak)

        guard let userDefaultsDM = container.resolve(UserDefaultsDataManagerProtocol.self),
            let coreDM = container.resolve(CoreDataManagerProtocol.self),
            let translationNS = container.resolve(TranslationNetworkServiceProtocol.self),
            let productNS = container.resolve(ProductNetworkServiceProtocol.self) else { return }

        container.register(MainAppTabBarFabricProtocol.self) { _ in
            MainAppTabBarFabric(container: container)
        }
        .inObjectScope(.container)

        // MARK: - ViewModels

        container.register(InsulinConfigViewModelProtocol.self) { _ in
            InsulinConfigViewModel(
                coreDM: coreDM,
                userDefaultsDM: userDefaultsDM)
        }

        container.register(NameRegisterViewModelProtocol.self) { _ in
            NameRegisterViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(NewNoteViewModelProtocol.self) { _ in
            NewNoteViewModel(coreDM: coreDM)
        }

        container.register(ProfileViewModelProtocol.self) { _ in
            ProfileViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(FoodConfigViewModelProtocol.self) { _ in
            FoodConfigViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(SugarConfigViewModelProtocol.self) { _ in
            SugarConfigViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(ProductViewModelProtocol.self) { _ in
            ProductViewModel(translationService: translationNS, productService: productNS, coreDM: coreDM)
        }

        container.register(TemplateViewModelProtocol.self) { _ in
            TemplateViewModel(coreDM: coreDM)
        }
    }
}
