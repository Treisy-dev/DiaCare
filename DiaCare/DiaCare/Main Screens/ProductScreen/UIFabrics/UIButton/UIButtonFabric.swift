//
//  UIButtonFabric.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit

final class UIButtonFabric {
    public static let shared = UIButtonFabric()

    private init() {
    }

    func makeAddButton() -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainApp
        button.layer.cornerRadius = 10
        return button
    }

    func makeCloseButton() -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.mainApp, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainApp.cgColor
        button.layer.cornerRadius = 10
        return button
    }
}
