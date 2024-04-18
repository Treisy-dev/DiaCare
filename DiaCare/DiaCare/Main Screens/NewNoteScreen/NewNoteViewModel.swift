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
}

final class NewNoteViewModel: NSObject, NewNoteViewModelProtocol, UITableViewDataSource {
    var averageSugar = "8.5"
    var coreDataManager: CoreDataManagerProtocol
    var userProducts: [UserProductModel] = []

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
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
}
