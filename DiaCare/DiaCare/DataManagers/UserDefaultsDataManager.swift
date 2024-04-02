//
//  UserDefaultsDataManager.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation

protocol UserDefaultsDataManagerProtocol {
    func getUserInfo() -> [String: String]

    func addNameToUserInfo(name: String?, email: String?)

    func addSugarConfigToUserInfo(lowSugar: String?, targetSugar: String?, hightSugar: String?)

    func addFoodConfigToUserInfo(breadCount: String?, insulinCount: String?)

    func addInsulinToUserInfo(shortInsulin: String?, longInsulin: String?)

    func prepareData(with userNameData: [String: String], for key: String) -> String
}

final class UserDefaultsDataManager: UserDefaultsDataManagerProtocol {

    var userInfo: [String: String] = [:]
    let userDefaults = UserDefaults.standard

    private func saveUserData() {
        userDefaults.setValue(true, forKey: "isUserLogged")
        userDefaults.set(userInfo, forKey: "userInfo")
    }

    func getUserInfo() -> [String: String] {
        guard let loadedDictionary = userDefaults.dictionary(forKey: "userInfo") as? [String: String] else { return [:] }
        return loadedDictionary
    }

    func addNameToUserInfo(name: String?, email: String?) {
        userInfo["name"] = name
        userInfo["email"] = email
    }

    func addSugarConfigToUserInfo(lowSugar: String?, targetSugar: String?, hightSugar: String?) {
        userInfo["lowSugar"] = lowSugar
        userInfo["targetSugar"] = targetSugar
        userInfo["hightSugar"] = hightSugar
    }

    func addFoodConfigToUserInfo(breadCount: String?, insulinCount: String?) {
        userInfo["breadCount"] = breadCount
        userInfo["insulinCount"] = insulinCount
    }

    func addInsulinToUserInfo(shortInsulin: String?, longInsulin: String?) {
        userInfo["shortInsulin"] = shortInsulin
        userInfo["longInsulin"] = longInsulin
        saveUserData()
    }

    func prepareData(with userNameData: [String: String], for key: String) -> String {
        guard let arg = userNameData[key] else { return ""}
        return arg
    }
}
