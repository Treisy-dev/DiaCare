//
//  CustomLanguageTextField.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.03.2024.
//
import SnapKit
import UIKit

class CustomLanguageTextField: UITextField {

    lazy var iconImageView: UIImageView = UIImageView()
    lazy var arrowImageView: UIImageView = UIImageView()
    lazy var languagePickerView: UIPickerView = UIPickerView()

    init(frame: CGRect, icon: UIImage, placeholder: String) {
        super.init(frame: frame)
        iconImageView.image = icon
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }

    func setupTextField() {
        self.inputView = languagePickerView
        self.layer.cornerRadius = 10
        self.borderStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.textAlignment = .center

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneAction: UIAction = UIAction { [weak self] _ in
            self?.resignFirstResponder()
        }
        let doneButton = UIBarButtonItem(title: "Done", image: nil, primaryAction: doneAction, menu: nil)
        toolbar.setItems([doneButton], animated: true)
        toolbar.backgroundColor = .gray
        self.inputAccessoryView = toolbar

        iconImageView.contentMode = .center

        self.leftView = iconImageView
        self.leftViewMode = .always

        let separatorView = UIView(frame: CGRect(x: 35, y: 5, width: 1, height: 20))
        separatorView.backgroundColor = UIColor.black
        self.addSubview(separatorView)

        self.rightView = arrowImageView
        self.rightViewMode = .always
        self.layoutIfNeeded()

        arrowImageView.image = UIImage(named: "DownArrowIconBlack")
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
