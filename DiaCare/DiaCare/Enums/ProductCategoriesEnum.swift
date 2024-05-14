//
//  ProductCategoriesEnum.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 15.05.2024.
//

import UIKit

enum ProductCategories: String {
    case fruit
    case vegetable
    case cereal
    case fish
    case meat
    case none

    func getImageByType() -> UIImage {
        switch self {
        case .fruit:
            return UIImage.fruit.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .vegetable:
            return UIImage.vegetable.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .cereal:
            return UIImage.cereal.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .fish:
            return UIImage.fish.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .meat:
            return UIImage.meat.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .none:
            return UIImage.lunch.resizeImage(newSize: CGSize(width: 45, height: 45))
        }
    }
}
