//
//  CustomCircledView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.04.2024.
//

import SnapKit
import UIKit

final class CustomCircledView: UIView {

    lazy var countLabel: UILabel = UILabel()

    init(frame: CGRect, color: UIColor, count: String) {
        super.init(frame: frame)
        setUp()
        layer.borderColor = color.cgColor
        countLabel.textColor = color
        countLabel.text = count
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpView()
        setUpSugarCountLabel()
    }

    private func setUpView() {
        layer.cornerRadius = 25
        layer.borderWidth = 2
    }

    private func setUpSugarCountLabel() {
        addSubview(countLabel)
        countLabel.font = UIFont.boldSystemFont(ofSize: 20)

        countLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
