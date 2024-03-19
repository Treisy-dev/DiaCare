//
//  UserDefaultsDataManager.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation

final class UserDefaultsDataManager {

    var userInfo: [String: String] = [:]
    let userDefaults = UserDefaults.standard
    public static let shared = UserDefaultsDataManager()

    private init() {
    }

    private func saveUserData() {
        userDefaults.setValue(true, forKey: "isUserLogged")
        userDefaults.set(userInfo, forKey: "userInfo")
    }

    func getUserInfo() -> [String: String] {
        guard let loadedDictionary = userDefaults.dictionary(forKey: "userInfo")
                as? [String: String] else { return [:] }
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
}
