//
//  ProductViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit

final class ProductViewModel: NSObject {

    let translationNS: TranslationNetworkServiceProtocol
    let productNS: ProductNetworkServiceProtocol

    init(translationService: TranslationNetworkServiceProtocol, productService: ProductNetworkServiceProtocol) {
        translationNS = translationService
        productNS = productService
    }

    func translateWord(word: String, completion: @escaping (String) -> Void) {
        translationNS.translateWord(word: word) {result in
            switch result {
            case .success(let word):
                completion(word)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getDefaultSizeProduct(product: String, completion: @escaping (ProductsResponse) -> Void) {
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
