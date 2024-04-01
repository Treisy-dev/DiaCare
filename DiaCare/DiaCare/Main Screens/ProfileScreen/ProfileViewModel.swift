//
//  ProfileViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import Foundation
import UIKit

final class ProfileViewModel: NSObject, UIPickerViewDataSource {
    let userDefaultsDataManager: UserDefaultsDataManagerProtocol
    let userInfoData: [String: String]
    let languageDataSource: [String] = ["Русский", "English"]

    init(userDefaultsDM: UserDefaultsDataManagerProtocol) {
        userDefaultsDataManager = userDefaultsDM
        userInfoData = userDefaultsDataManager.getUserInfo()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languageDataSource.count
    }

    func getSelectedLanguage() -> String {
        guard let language = UserDefaults.standard.string(forKey: "selectedLanguage") else { return "Выберете язык" }
        return language
    }
}
