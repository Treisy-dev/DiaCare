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
}

final class ProductViewModel: NSObject, ProductViewModelProtocol {

    var translationNS: TranslationNetworkServiceProtocol
    var productNS: ProductNetworkServiceProtocol
    var coreDataManager: CoreDataManagerProtocol

    var productItem: [Product] = []

    init(
        translationService: TranslationNetworkServiceProtocol,
        productService: ProductNetworkServiceProtocol,
        coreDM: CoreDataManagerProtocol) {
        translationNS = translationService
        productNS = productService
        coreDataManager = coreDM
    }

    func searchProducts(for queryText: String, completion: @escaping () -> Void) {
        translateWord(word: queryText) { [weak self] result in
            self?.getDefaultSizeProduct(product: result) { [weak self] product in
                self?.productItem = product.items
                completion()
            }
        }
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
}

extension ProductViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCategory = coreDataManager.obtainCategoryFromProduct(for: productItem[indexPath.row].name)
        let cell = ProductTableViewCell(style: .default, reuseIdentifier: nil)
        let category = cell.getCategoryFromString(productCategory ?? "")
        cell.config(
            productName: productItem[indexPath.row].name,
            productCategory: category,
            proteinCount: String(productItem[indexPath.row].protein_g),
            fatCount: String(productItem[indexPath.row].fat_total_g),
            carbCount: String(productItem[indexPath.row].carbohydrates_total_g))
        return cell
    }
}
