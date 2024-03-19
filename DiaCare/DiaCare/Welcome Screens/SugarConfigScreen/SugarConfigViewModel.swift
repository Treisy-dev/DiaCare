//
//  SugarConfigViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation
import UIKit

final class SugarConfigViewModel: NSObject, UIPickerViewDataSource {

    var dataSource: [String] = []

    override init() {
        super.init()
        generateDataArray()
    }

    func saveUserInfo(lowSugar: String?, targetSugar: String?, hightSugar: String?) {
        UserDefaultsDataManager.shared.addSugarConfigToUserInfo(
            lowSugar: lowSugar,
            targetSugar: targetSugar,
            hightSugar: hightSugar)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    private func generateDataArray() {
        var currentValue = 2.0
        let endValue = 20.0
        let step = 0.1

        while currentValue <= endValue {
            dataSource.append(String(format: "%.1f", currentValue))
            currentValue += step
        }
    }
}
