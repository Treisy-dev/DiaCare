//
//  NewTemplateViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//

import UIKit

protocol NewTemplateViewModelProtocol: UITableViewDataSource, UIPickerViewDataSource {
    var userProducts: [UserProductModel] { get }
    var pickerViewDataSource: [String] { get }

    func getBreadCount() -> String
    func getInsulinCount() -> String
    func getFatCount() -> String
    func getProteinCount() -> String
    func getCarbsCount() -> String
    func saveNewTemplate(breadCount: String, shortInsulin: String, name: String, category: String)
    func addUserProduct(product: UserProductModel)
}

final class NewTemplateViewModel: NSObject, NewTemplateViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol
    var userDefaultsDataManager: UserDefaultsDataManagerProtocol
    var userProducts: [UserProductModel] = []
    var pickerViewDataSource: [String] = ["Завтрак", "Перекус", "Второй завтрак", "Обед", "Ужин", "Второй ужин"]

    init(coreDM: CoreDataManagerProtocol, userDefaultsDM: UserDefaultsDataManagerProtocol) {
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCategory = coreDataManager.obtainCategoryFromProduct(for: userProducts[indexPath.row].name)
        let cell = UserProductTableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        if productCategory == nil {
            let temlateCategory = coreDataManager.obtainCategoryFromTemplate(for: userProducts[indexPath.row].name)
            let category = getCategoryFromStringTemplate(temlateCategory ?? "")
            cell.configTemplate(
                productName: userProducts[indexPath.row].name,
                templateCategory: category,
                proteinCount: userProducts[indexPath.row].protein,
                productStats: (userProducts[indexPath.row].fat, userProducts[indexPath.row].carbs, userProducts[indexPath.row].breadCount)
            )
        } else {
            let category = getCategoryFromStringProduct(productCategory ?? "")
            cell.config(
                productName: userProducts[indexPath.row].name,
                productCategory: category,
                proteinCount: userProducts[indexPath.row].protein,
                productStats: (userProducts[indexPath.row].fat, userProducts[indexPath.row].carbs, userProducts[indexPath.row].breadCount)
            )
        }
        return cell
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewDataSource.count
    }

    func saveNewTemplate(breadCount: String, shortInsulin: String, name: String, category: String) {
        coreDataManager.addNewTemplate(
            breadCount: breadCount,
            shortInsulin: shortInsulin,
            templateName: name,
            category: category,
            products: userProducts
        )
    }

    func getFatCount() -> String {
        var result: Double = 0
        for product in userProducts {
            guard let fatCount = Double(product.fat) else { return ""}
            result += fatCount
        }
        return String(format: "%.1f", result)
    }

    func getProteinCount() -> String {
        var result: Double = 0
        for product in userProducts {
            guard let proteinCount = Double(product.protein) else { return ""}
            result += proteinCount
        }
        return String(format: "%.1f", result)
    }

    func getCarbsCount() -> String {
        var result: Double = 0
        for product in userProducts {
            guard let carbsCount = Double(product.carbs) else { return ""}
            result += carbsCount
        }
        return String(format: "%.1f", result)
    }

    func getBreadCount() -> String {
        var result: Double = 0
        for product in userProducts {
            guard let breadCount = Double(product.breadCount) else { return ""}
            result += breadCount
        }
        return String(format: "%.1f", result)
    }

    func getInsulinCount() -> String {
        guard let breadCount = Double(getBreadCount()) else { return ""}
        guard let insulinCount = Double(userDefaultsDataManager.getUserInsulinCount()) else { return ""}

        return String(format: "%.1f", breadCount * insulinCount)
    }

    func addUserProduct(product: UserProductModel) {
        userProducts.append(product)
    }

    private func getCategoryFromStringProduct(_ categoryString: String) -> ProductCategories {
        if let category = ProductCategories(rawValue: categoryString) {
            return category
        } else {
            return .none
        }
    }

    private func getCategoryFromStringTemplate(_ categoryString: String) -> TemplateCategories {
        if let category = TemplateCategories(rawValue: categoryString) {
            return category
        } else {
            return .none
        }
    }
}
