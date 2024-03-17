//
//  UIImageExtensions.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 17.03.2024.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
