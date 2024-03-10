//
//  InsulinConfigViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation
import UIKit

class InsulinConfigViewModel: NSObject, UIPickerViewDataSource {

    var shortPickerView: UIPickerView?
    var longPickerView: UIPickerView?

    var shortDataSource: [String] = ["Хумалог", "НовоРапид", "Апидра"]
    var longDataSource: [String] = ["Лантус", "Туджео", "Левемир"]

    override init() {
        super.init()
    }

    func saveUserInfo(shortInsulin: String?, longInsulin: String?) {
        UserDefaultsDataManager.shared.addInsulinToUserInfo(shortInsulin: shortInsulin, longInsulin: longInsulin)
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
