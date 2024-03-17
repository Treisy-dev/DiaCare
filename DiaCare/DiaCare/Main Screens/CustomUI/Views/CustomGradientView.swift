//
//  CustomGradientView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

class CustomGradientView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUp() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [UIColor.mainApp.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}
