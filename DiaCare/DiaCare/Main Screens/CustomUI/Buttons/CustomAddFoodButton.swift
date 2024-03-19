//
//  CustomAddFoodButton.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.03.2024.
//
import SnapKit
import UIKit

final class CustomAddFoodButton: UIButton {

    private let buttonView: UIView = UIView()
    private let buttonImageView: UIImageView = UIImageView()
    private let buttonLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        addSubview(buttonView)
        buttonView.layer.cornerRadius = 10
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.lightGray.cgColor
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        buttonView.addSubview(buttonImageView)
        buttonImageView.image = UIImage.plusIcon
        buttonImageView.contentMode = .scaleAspectFill
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }

        buttonView.addSubview(buttonLabel)
        buttonLabel.text = "Добавить продукт"
        buttonLabel.textColor = .lightGray
        buttonLabel.textAlignment = .center

        buttonLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonImageView.snp_trailingMargin).offset(15)
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalTo(buttonImageView.snp_centerYWithinMargins)
        }
    }
}
