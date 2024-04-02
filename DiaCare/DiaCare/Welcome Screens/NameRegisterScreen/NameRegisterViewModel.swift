//
//  NameRegisterViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation

protocol NameRegisterViewModelProtocol {
    var welcomeScreenFabric: WelcomeScreensControllerFabricProtocol { get }
    func saveUserInfo(name: String?, email: String?)
}

final class NameRegisterViewModel: NameRegisterViewModelProtocol {

    let userDefaultsDataManager: UserDefaultsDataManagerProtocol
    let welcomeScreenFabric: WelcomeScreensControllerFabricProtocol

    init(userDefaultsDM: UserDefaultsDataManagerProtocol, welcomeScreenControllerFabric: WelcomeScreensControllerFabricProtocol) {
        welcomeScreenFabric = welcomeScreenControllerFabric
        userDefaultsDataManager = userDefaultsDM
    }

    func saveUserInfo(name: String?, email: String?) {
        userDefaultsDataManager.addNameToUserInfo(name: name, email: email)
    }
}
