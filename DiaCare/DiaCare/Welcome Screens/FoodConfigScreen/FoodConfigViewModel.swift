//
//  FoodConfigViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation
import UIKit

protocol FoodConfigViewModelProtocol: UIPickerViewDataSource {
    var dataSource: [String] { get set }
    func saveUserInfo(breadCount: String?, insulinCount: String?)
}

final class FoodConfigViewModel: NSObject, UIPickerViewDataSource, FoodConfigViewModelProtocol {

    let userDefaultsDataManager: UserDefaultsDataManagerProtocol

    var dataSource: [String] = []

    init(userDefaultsDM: UserDefaultsDataManagerProtocol) {
        userDefaultsDataManager = userDefaultsDM
        super.init()
        generateDataArray()
    }

    func saveUserInfo(breadCount: String?, insulinCount: String?) {
        userDefaultsDataManager.addFoodConfigToUserInfo(breadCount: breadCount, insulinCount: insulinCount)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    private func generateDataArray() {
        var currentValue = 0.1
        let endValue = 5.0
        let step = 0.1

        while currentValue <= endValue {
            dataSource.append(String(format: "%.1f", currentValue))
            currentValue += step
        }
    }
}
