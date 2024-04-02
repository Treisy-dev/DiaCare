//
//  UITableViewExtensions.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
