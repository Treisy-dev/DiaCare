//
//  NameRegisterViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation

protocol NameRegisterViewModelProtocol {
    func saveUserInfo(name: String?, email: String?)
}

final class NameRegisterViewModel: NameRegisterViewModelProtocol {

    let userDefaultsDataManager: UserDefaultsDataManagerProtocol

    init(userDefaultsDM: UserDefaultsDataManagerProtocol) {
        userDefaultsDataManager = userDefaultsDM
    }

    func saveUserInfo(name: String?, email: String?) {
        userDefaultsDataManager.addNameToUserInfo(name: name, email: email)
    }
}
