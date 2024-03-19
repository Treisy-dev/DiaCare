//
//  NameRegisterViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation

final class NameRegisterViewModel {
    func saveUserInfo(name: String?, email: String?) {
        UserDefaultsDataManager.shared.addNameToUserInfo(name: name, email: email)
    }
}
