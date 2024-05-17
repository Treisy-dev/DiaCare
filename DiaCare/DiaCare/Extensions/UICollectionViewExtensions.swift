//
//  UICollectionViewExtensions.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
