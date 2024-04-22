//
//  NewNoteViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import Foundation
import UIKit

protocol NewNoteViewModelProtocol: UITableViewDataSource {
    var averageSugar: String { get }
    var userProducts: [UserProductModel] {get set}
    func saveNewNote(breadCount: String, sugar: String, shortInsulin: String)
    func getBreadCount() -> String
    func getInsulinCount() -> String
    func getAverageSugar() -> String
}

final class NewNoteViewModel: NSObject, NewNoteViewModelProtocol, UITableViewDataSource {
    var averageSugar: String
    var coreDataManager: CoreDataManagerProtocol
    var userDefaultsDataManager: UserDefaultsDataManagerProtocol
    var userProducts: [UserProductModel] = []

    init(coreDM: CoreDataManagerProtocol, userDefaultsDM: UserDefaultsDataManagerProtocol) {
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
        averageSugar = coreDataManager.obtainAverageSugar()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCategory = coreDataManager.obtainCategoryFromProduct(for: userProducts[indexPath.row].name)
        let cell = UserProductTableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let category = cell.getCategoryFromString(productCategory ?? "")
        cell.config(
            productName: userProducts[indexPath.row].name,
            productCategory: category,
            proteinCount: userProducts[indexPath.row].protein,
            fatCount: userProducts[indexPath.row].fat,
            carbCount: userProducts[indexPath.row].carbs,
            breadCount: userProducts[indexPath.row].breadCount
        )
        return cell
    }

    func getAverageSugar() -> String {
        averageSugar = coreDataManager.obtainAverageSugar()
        return averageSugar
    }

    func saveNewNote(breadCount: String, sugar: String, shortInsulin: String) {
        coreDataManager.addToHistory(breadCount: breadCount, sugar: sugar, shortInsulin: shortInsulin)
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
}
