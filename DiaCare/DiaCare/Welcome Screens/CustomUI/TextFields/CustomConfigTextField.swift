//
//  CustomConfigTextField.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//
import SnapKit
import UIKit

class CustomConfigTextField: UITextField {

    let iconImageView: UIImageView = UIImageView()
    let arrowImageView: UIImageView = UIImageView()

    init(frame: CGRect, icon: UIImage, placeholder: String) {
        super.init(frame: frame)
        iconImageView.image = icon
        self.placeholder = placeholder
        setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }

    func setupTextField() {
        self.layer.cornerRadius = 10
        self.borderStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.textAlignment = .center

        iconImageView.contentMode = .center

        self.leftView = iconImageView
        self.leftViewMode = .always

        let separatorView = UIView(frame: CGRect(x: 35, y: 5, width: 1, height: 30))
        separatorView.backgroundColor = UIColor.lightGray
        self.addSubview(separatorView)

        self.rightView = arrowImageView
        self.rightViewMode = .always
        self.layoutIfNeeded()

        arrowImageView.image = UIImage(named: "DownArrow")
        arrowImageView.contentMode = .center
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self).offset(8)
            make.width.equalTo(35)
            make.height.equalTo(40)
        }

        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self).offset(-8)
            make.width.equalTo(35)
            make.height.equalTo(40)
        }
    }
}
