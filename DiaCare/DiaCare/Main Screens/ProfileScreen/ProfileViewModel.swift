//
//  ProfileViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject, UIPickerViewDataSource {
    let userInfoData: [String: String] = UserDefaultsDataManager.shared.getUserInfo()
    let languageDataSource: [String] = ["Русский", "English"]

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
