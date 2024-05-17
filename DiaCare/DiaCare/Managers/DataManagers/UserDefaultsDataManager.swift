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
    func getUserBreadCount() -> String
    func getUserInsulinCount() -> String
    func getLowTarget() -> String
    func getAverageTarget() -> String
    func getHighTarget() -> String
}

final class UserDefaultsDataManager: UserDefaultsDataManagerProtocol {

    let userDefaults = UserDefaults.standard

    var userInfo: [String: String] = [:]

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

    func getUserBreadCount() -> String {
        guard let breadCount = getUserInfo()["breadCount"] else { return "10"}
        return breadCount
    }

    func getUserInsulinCount() -> String {
        guard let insulinCount = getUserInfo()["insulinCount"] else { return "1"}
        return insulinCount
    }

    func getLowTarget() -> String {
        guard let lowSugar = getUserInfo()["lowSugar"] else { return "4.0"}
        return lowSugar
    }

    func getAverageTarget() -> String {
        guard let averageSugar = getUserInfo()["targetSugar"] else { return "7.0"}
        return averageSugar
    }

    func getHighTarget() -> String {
        guard let highSugar = getUserInfo()["hightSugar"] else { return "10.0"}
        return highSugar
    }

    private func saveUserData() {
        userDefaults.setValue(true, forKey: "isUserLogged")
        userDefaults.set(userInfo, forKey: "userInfo")
    }
}
