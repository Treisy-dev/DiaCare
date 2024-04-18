//
//  UIButtonExtensions.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.04.2024.
//

import UIKit

extension UIButton {
    func addAlphaAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        })
    }
}
