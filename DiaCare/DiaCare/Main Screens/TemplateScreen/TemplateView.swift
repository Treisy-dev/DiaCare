//
//  TemplateView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

class TemplateView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
