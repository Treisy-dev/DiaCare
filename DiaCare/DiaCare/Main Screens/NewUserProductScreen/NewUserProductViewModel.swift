//
//  NewUserProductViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.04.2024.
//

import UIKit
import Combine

protocol NewUserProductViewModelProtocol: UIPickerViewDataSource {
    var productCategory: CurrentValueSubject<String?, Never> { get }
    var productName: CurrentValueSubject<String?, Never> { get }
    var fatCount: CurrentValueSubject<String?, Never> { get }
    var proteinCount: CurrentValueSubject<String?, Never> { get }
    var carbsCount: CurrentValueSubject<String?, Never> { get }
    var dataSource: [String] { get }

    func saveProduct()
}

final class NewUserProductViewModel: NSObject, NewUserProductViewModelProtocol {
    var productCategory: CurrentValueSubject<String?, Never> = .init("")
    var productName: CurrentValueSubject<String?, Never> = .init("")
    var fatCount: CurrentValueSubject<String?, Never> = .init("")
    var proteinCount: CurrentValueSubject<String?, Never> = .init("")
    var carbsCount: CurrentValueSubject<String?, Never> = .init("")
    var dataSource: [String] = []
    var coreDataManager: CoreDataManagerProtocol

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
        dataSource = coreDataManager.obtainAllCategories()
        super.init()
        dataSource.sort { $0 < $1 }
        addNoneTypeIfNeeded()
    }

    func saveProduct() {
        guard let category = productCategory.value,
            let name = productName.value,
            let protein = proteinCount.value,
            let fat = fatCount.value,
            let carbs = carbsCount.value else { return }

        coreDataManager.addUserProduct(
            category: category,
            name: name,
            protein: protein,
            fat: fat,
            carbs: carbs
        )
    }

    private func addNoneTypeIfNeeded() {
        if !dataSource.contains(where: {$0 == "Продукт без категории"}) {
            dataSource.insert("Продукт без категории", at: 0)
        }
    }
}

extension NewUserProductViewModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}
