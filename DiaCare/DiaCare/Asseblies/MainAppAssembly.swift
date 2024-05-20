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

        container.register(MainAppModuleFactoryProtocol.self) { _ in
            MainAppModuleFactory(container: container)
        }
        .inObjectScope(.weak)

        container.register(TabBarModuleFactoryProtocol.self) { _ in
            TabBarModuleFactory(container: container)
        }
        .inObjectScope(.weak)

        container.register(WelcomeModuleFactoryProtocol.self) { _ in
            WelcomeModuleFactory(container: container)
        }
        .inObjectScope(.weak)

        guard let userDefaultsDM = container.resolve(UserDefaultsDataManagerProtocol.self),
            let coreDM = container.resolve(CoreDataManagerProtocol.self),
            let translationNS = container.resolve(TranslationNetworkServiceProtocol.self),
            let productNS = container.resolve(ProductNetworkServiceProtocol.self),
            let mainAppModuleFactory = container.resolve(MainAppModuleFactoryProtocol.self),
            let tabBarModuleFactory = container.resolve(TabBarModuleFactoryProtocol.self) else { return }

        container.register(MainAppTabBarFabricProtocol.self) { _ in
            MainAppTabBarFabric(mainAppModuleFactory: mainAppModuleFactory, tabBarModuleFactory: tabBarModuleFactory )
        }
        .inObjectScope(.container)

        // MARK: - ViewModels

        container.register(InsulinConfigViewModelProtocol.self) { _ in
            InsulinConfigViewModel(coreDM: coreDM, userDefaultsDM: userDefaultsDM)
        }

        container.register(NameRegisterViewModelProtocol.self) { _ in
            NameRegisterViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(NewNoteViewModelProtocol.self) { _ in
            NewNoteViewModel(coreDM: coreDM, userDefaultsDM: userDefaultsDM)
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
            ProductViewModel(
                translationService: translationNS,
                productService: productNS,
                coreDM: coreDM,
                userDefaultsDM: userDefaultsDM
            )
        }

        container.register(TemplateViewModelProtocol.self) { _ in
            TemplateViewModel(coreDM: coreDM)
        }

        container.register(ProductConfigViewModelProtocol.self) { _ in
            ProductConfigViewModel(userDefaultsDM: userDefaultsDM)
        }

        container.register(NewUserProductViewModelProtocol.self) { _ in
            NewUserProductViewModel(coreDM: coreDM)
        }

        container.register(NotificationViewModelProtocol.self) { _ in
            NotificationViewModel(coreDM: coreDM)
        }

        container.register(StatisticViewModelProtocol.self) { _ in
            StatisticViewModel(coreDM: coreDM, userDefaultsDM: userDefaultsDM)
        }

        container.register(NewTemplateViewModelProtocol.self) { _ in
            NewTemplateViewModel(coreDM: coreDM, userDefaultsDM: userDefaultsDM)
        }
    }
}
