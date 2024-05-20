//
//  SceneDelegate.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let container = Container()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        let mainAppAssembly = MainAppAssembly()
        mainAppAssembly.assemble(container: container)

        guard let welcomeModuleFactory = container.resolve(WelcomeModuleFactoryProtocol.self) else { return }

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        if UserDefaults.standard.bool(forKey: "isUserLogged") {
            let tbController = welcomeModuleFactory.createMainAppTabBar()
            self.window?.rootViewController = tbController
            self.window?.makeKeyAndVisible()
        } else {
            let welcomeFlowCoordinator = WelcomeFlowCoordinator(moduleFactory: welcomeModuleFactory, navigationController: UINavigationController())
            welcomeFlowCoordinator.start()

            let navigationController = welcomeFlowCoordinator.navigationController
            navigationController.isNavigationBarHidden = true
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily
        // discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        guard let coreDataManager = container.resolve(CoreDataManagerProtocol.self) else { return }
        coreDataManager.saveContext()
    }
}
