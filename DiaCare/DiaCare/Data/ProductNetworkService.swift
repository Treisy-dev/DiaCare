//
//  ProductNetworkService.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 28.03.2024.
//

import Foundation
import Alamofire

protocol ProductNetworkServiceProtocol {
    func getDefaultSizeProduct(with product: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void)
}

final class ProductNetworkService: ProductNetworkServiceProtocol {

    var productHeaders: HTTPHeaders = [
        "X-Api-Key": "YnrJ0bBHVqD1sWJ3UrV7bA==fCVcjgy3StGgYjG1"
    ]

    func getDefaultSizeProduct(with product: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        makeProductRequest(with: product) { result in
            switch result {
            case .success(let product):
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func makeProductRequest(with product: String, completion: @escaping (Result<ProductsResponse, Error>) -> Void) {

        AF.request(
            "https://api.calorieninjas.com/v1/nutrition?query=100g " + product,
            method: .get,
            encoding: JSONEncoding.default,
            headers: productHeaders).responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(ProductsResponse.self, from: value)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
