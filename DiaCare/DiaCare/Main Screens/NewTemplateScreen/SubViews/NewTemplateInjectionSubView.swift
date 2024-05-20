//
//  NewTemplateInjectionSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class NewTemplateInjectionSubView: UIView {

    lazy var breadCountTextField: UITextField = UITextField()
    lazy var insulinTextField: UITextField = UITextField()

    private lazy var breadCountLabel: UILabel = UILabel()
    private lazy var insulinLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBreadCountLabel()
        setUpBreadCountTextField()
        setUpInsulinLabel()
        setUpInsulinTextField()
    }

    private func setUpBreadCountLabel() {
        addSubview(breadCountLabel)
        breadCountLabel.text = "Количество ХЕ"
        breadCountLabel.textColor = .systemGray
        breadCountLabel.font = UIFont.systemFont(ofSize: 16)
        breadCountLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }

    private func setUpBreadCountTextField() {
        addSubview(breadCountTextField)
        breadCountTextField.textAlignment = .center
        breadCountTextField.keyboardType = .numberPad
        breadCountTextField.layer.cornerRadius = 10
        breadCountTextField.layer.borderColor = UIColor.systemGray.cgColor
        breadCountTextField.layer.borderWidth = 1
        breadCountTextField.snp.makeConstraints { make in
            make.top.equalTo(breadCountLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }

    private func setUpInsulinLabel() {
        addSubview(insulinLabel)
        insulinLabel.text = "Количество единиц инсулина"
        insulinLabel.textColor = .systemGray
        insulinLabel.font = UIFont.systemFont(ofSize: 16)
        insulinLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(breadCountTextField.snp.bottom).offset(10)
        }
    }

    private func setUpInsulinTextField() {
        addSubview(insulinTextField)
        insulinTextField.textAlignment = .center
        insulinTextField.keyboardType = .numberPad
        insulinTextField.layer.cornerRadius = 10
        insulinTextField.layer.borderColor = UIColor.systemGray.cgColor
        insulinTextField.layer.borderWidth = 1
        insulinTextField.snp.makeConstraints { make in
            make.top.equalTo(insulinLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}
