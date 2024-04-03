//
//  ProductAPIModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 28.03.2024.
//

import Foundation

struct Product: Decodable {
    let name: String
    let calories: Double
    let serving_size_g: Double
    let fat_total_g: Double
    let protein_g: Double
    let carbohydrates_total_g: Double
}

struct ProductsResponse: Decodable {
    let items: [Product]
}
