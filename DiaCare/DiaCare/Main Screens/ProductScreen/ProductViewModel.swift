//
//  ProductViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit
import Combine

protocol ProductViewModelProtocol: UITableViewDataSource {
    func searchProducts(for queryText: String, completion: @escaping () -> Void)
    func getUserSavedProducts()
    func getUserTemplates()
    var productItem: [Product] { get }
    var usersProduct: [UserProductModel] { get set }
    var userSavedProducts: [UserProducts] { get }
    var userTemplates: [Templates] { get }
    var selectedSegmentControllIndex: Int { get set }
    func getProteintForTemplate(for template: Templates) -> String
    func getFatForTemplate(for template: Templates) -> String
    func getCarbsForTemplate(for template: Templates) -> String
}

final class ProductViewModel: NSObject, ProductViewModelProtocol {

    var translationNS: TranslationNetworkServiceProtocol
    var productNS: ProductNetworkServiceProtocol
    var coreDataManager: CoreDataManagerProtocol
    var userDefaultsDataManager: UserDefaultsDataManagerProtocol
    var selectedSegmentControllIndex: Int = 0
    var usersProduct: [UserProductModel] = []
    var productItem: [Product] = []
    var userSavedProducts: [UserProducts] = []
    var userTemplates: [Templates] = []

    init(
        translationService: TranslationNetworkServiceProtocol,
        productService: ProductNetworkServiceProtocol,
        coreDM: CoreDataManagerProtocol,
        userDefaultsDM: UserDefaultsDataManagerProtocol) {
            translationNS = translationService
            productNS = productService
            coreDataManager = coreDM
            userDefaultsDataManager = userDefaultsDM
    }

    func searchProducts(for queryText: String, completion: @escaping () -> Void) {
        translateWord(word: queryText) { [weak self] result in
            self?.getDefaultSizeProduct(product: result) { [weak self] product in
                self?.productItem = product.items
                completion()
            }
        }
    }

    func getUserSavedProducts() {
        userSavedProducts = coreDataManager.obtainUsersProduct()
    }

    func getUserTemplates() {
        userTemplates = coreDataManager.obtainUsersTemplates()
    }

    func getProteintForTemplate(for template: Templates) -> String {
        var result: Double = 0
        guard let products = template.templateProduct?.allObjects as? [TemplateProduct] else { return ""}
        for product in products {
            guard let protein = Double(product.protein) else { return ""}
            result += protein
        }
        return String(format: "%.1f", result)
    }

    func getFatForTemplate(for template: Templates) -> String {
        var result: Double = 0
        guard let products = template.templateProduct?.allObjects as? [TemplateProduct] else { return ""}
        for product in products {
            guard let fat = Double(product.fat) else { return ""}
            result += fat
        }
        return String(format: "%.1f", result)
    }

    func getCarbsForTemplate(for template: Templates) -> String {
        var result: Double = 0
        guard let products = template.templateProduct?.allObjects as? [TemplateProduct] else { return ""}
        for product in products {
            guard let carbohydrates = Double(product.carbohydrates) else { return ""}
            result += carbohydrates
        }
        return String(format: "%.1f", result)
    }

    private func translateWord(word: String, completion: @escaping (String) -> Void) {
        translationNS.translateWord(word: word) {result in
            switch result {
            case .success(let word):
                completion(word)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getDefaultSizeProduct(product: String, completion: @escaping (ProductsResponse) -> Void) {
        productNS.getDefaultSizeProduct(with: product) { result in
            switch result {
            case .success(let product):
                completion(product)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getCarbsCount(breadCount: String) -> String {
        guard let carbsInBreadCount = Double(userDefaultsDataManager.getUserBreadCount()),
            let breadCountDouble = Double(breadCount) else { return ""}

        return String(format: "%.1f", breadCountDouble * carbsInBreadCount)
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

extension ProductViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegmentControllIndex == 0 {
            return productItem.count
        } else if selectedSegmentControllIndex == 1 {
            return userTemplates.count
        } else {
            return userSavedProducts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedSegmentControllIndex == 0 {
            let productCategory = coreDataManager.obtainCategoryFromProduct(for: productItem[indexPath.row].name)
            let cell = ProductTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            let category = getCategoryFromStringProduct(productCategory ?? "")
            cell.config(
                productName: productItem[indexPath.row].name,
                productCategory: category,
                proteinCount: String(productItem[indexPath.row].protein_g),
                fatCount: String(productItem[indexPath.row].fat_total_g),
                carbCount: String(productItem[indexPath.row].carbohydrates_total_g))
            return cell
        } else if selectedSegmentControllIndex == 1 {
            let productCategory = coreDataManager.obtainCategoryFromTemplate(for: userTemplates[indexPath.row].name)
            let cell = ProductTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            let category = getCategoryFromStringTemplate(productCategory ?? "")
            cell.configTemplate(
                productName: userTemplates[indexPath.row].name,
                templateCategory: category,
                breadCount: String(userTemplates[indexPath.row].breadCount),
                insulinCount: String(userTemplates[indexPath.row].insulin),
                carbCount: String(getCarbsCount(breadCount: userTemplates[indexPath.row].breadCount)))
            return cell
        } else {
            let cell = ProductTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            let category = getCategoryFromStringProduct(userSavedProducts[indexPath.row].category)
            cell.config(
                productName: userSavedProducts[indexPath.row].name,
                productCategory: category,
                proteinCount: String(userSavedProducts[indexPath.row].protein),
                fatCount: String(userSavedProducts[indexPath.row].fat),
                carbCount: String(userSavedProducts[indexPath.row].carbohydrates))
            return cell
        }
    }
}
