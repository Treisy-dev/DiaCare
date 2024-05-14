//
//  TemplateCategoriesEnum.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 15.05.2024.
//

import UIKit

enum TemplateCategories: String {
    case breakfast
    case snack
    case secondBreakfast
    case lunch
    case dinner
    case afternoonSnack
    case none

    func getImageByType() -> UIImage {
        switch self {
        case .breakfast:
            return UIImage.breakfast.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .snack:
            return UIImage.snack.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .secondBreakfast:
            return UIImage.secondBreakfast.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .lunch:
            return UIImage.lunch.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .dinner:
            return UIImage.diner.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .afternoonSnack:
            return UIImage.afternoonSnack.resizeImage(newSize: CGSize(width: 45, height: 45))
        case .none:
            return UIImage.afternoonSnack.resizeImage(newSize: CGSize(width: 45, height: 45))
        }
    }
}
