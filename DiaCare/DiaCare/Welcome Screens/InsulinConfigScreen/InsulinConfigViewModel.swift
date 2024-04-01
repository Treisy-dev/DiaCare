//
//  InsulinConfigViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import Foundation
import UIKit

final class InsulinConfigViewModel: NSObject, UIPickerViewDataSource {

    var shortPickerView: UIPickerView?
    var longPickerView: UIPickerView?
    let coreDataManager: CoreDataManagerProtocol
    let userDefaultsDataManager: UserDefaultsDataManagerProtocol
    let welcomeScreenFabric: WelcomeScreensControllerFabricProtocol

    var shortDataSource: [String] = ["Хумалог", "НовоРапид", "Апидра"]
    var longDataSource: [String] = ["Лантус", "Туджео", "Левемир"]

    init(
        coreDM: CoreDataManagerProtocol,
        userDefaultsDM: UserDefaultsDataManagerProtocol,
        welcomeScreenControllerFabric: WelcomeScreensControllerFabricProtocol) {
        welcomeScreenFabric = welcomeScreenControllerFabric
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
    }

    func saveUserInfo(shortInsulin: String?, longInsulin: String?) {
        userDefaultsDataManager.addInsulinToUserInfo(shortInsulin: shortInsulin, longInsulin: longInsulin)
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
