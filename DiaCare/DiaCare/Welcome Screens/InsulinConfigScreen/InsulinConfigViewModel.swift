//
//  InsulinConfigViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation
import UIKit

protocol InsulinConfigViewModelProtocol: UIPickerViewDataSource {
    var shortDataSource: [String] { get }
    var longDataSource: [String] { get }

    func saveUserInfo(shortInsulin: String?, longInsulin: String?)
    func setUpDefaultsProductTypes()
}

final class InsulinConfigViewModel: NSObject, UIPickerViewDataSource, InsulinConfigViewModelProtocol {

    let coreDataManager: CoreDataManagerProtocol
    let userDefaultsDataManager: UserDefaultsDataManagerProtocol

    var shortPickerView: UIPickerView?
    var longPickerView: UIPickerView?
    var shortDataSource: [String] = ["Хумалог", "НовоРапид", "Апидра"]
    var longDataSource: [String] = ["Лантус", "Туджео", "Левемир"]

    init(
        coreDM: CoreDataManagerProtocol,
        userDefaultsDM: UserDefaultsDataManagerProtocol) {
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
    }

    func saveUserInfo(shortInsulin: String?, longInsulin: String?) {
        userDefaultsDataManager.addInsulinToUserInfo(shortInsulin: shortInsulin, longInsulin: longInsulin)
    }

    func setUpDefaultsProductTypes() {
        coreDataManager.setUpDefaultProductTypes()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == shortPickerView {
            return shortDataSource.count
        } else {
            return longDataSource.count
        }
    }
}
