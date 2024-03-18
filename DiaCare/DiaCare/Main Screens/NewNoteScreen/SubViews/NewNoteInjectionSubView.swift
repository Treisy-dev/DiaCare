//
//  NewNoteInjectionSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 16.03.2024.
//

import SnapKit
import UIKit

class NewNoteInjectionSubView: UIView {

    lazy var breadTextField: UITextField = UITextField()
    private lazy var breadLabel: UILabel = UILabel()
    lazy var breadSlider: UISlider = UISlider()

    lazy var insulinTextField: UITextField = UITextField()
    private lazy var insulinLabel: UILabel = UILabel()
    lazy var insulinSlider: UISlider = UISlider()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray.withAlphaComponent(0.15)
        self.layer.cornerRadius = 18
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBreadLabel()
        setUpBreadTextField()
        setUpBreadSlider()
        setUpInsulinLabel()
        setUpInsulinTextField()
        setUpInsulinSlider()
    }

    private func setUpBreadLabel() {
        addSubview(breadLabel)
        breadLabel.text = "Итоговое количество ХЕ"
        breadLabel.font = UIFont.systemFont(ofSize: 16)
        breadLabel.textColor = .lightGray

        breadLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(30)
        }
    }

    private func setUpBreadTextField() {
        addSubview(breadTextField)
        breadTextField.textAlignment = .center
        breadTextField.text = "0"
        breadTextField.layer.cornerRadius = 10
        breadTextField.keyboardType = .numbersAndPunctuation
        breadTextField.layer.borderWidth = 1
        breadTextField.layer.borderColor = UIColor.lightGray.cgColor
        breadTextField.backgroundColor = .white
        let changeAction = UIAction { [weak self] _ in
            if let text = self?.breadTextField.text, let value = Float(text) {
                self?.breadSlider.value = value
            }
        }
        breadTextField.addAction(changeAction, for: .editingChanged)
        breadTextField.snp.makeConstraints { make in
            make.top.equalTo(breadLabel.snp_bottomMargin).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(36)
        }
    }

    private func setUpBreadSlider() {
        breadSlider.minimumTrackTintColor = .mainApp
        breadSlider.maximumValue = 30
        breadSlider.minimumValue = 0
        addSubview(breadSlider)
        breadSlider.maximumTrackTintColor = .mainApp.withAlphaComponent(0.2)
        breadSlider.thumbTintColor = .mainApp
        breadSlider.value = 0

        breadSlider.setThumbImage(UIImage.sliderThumbIcon, for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.breadSlider.value else { return }
            self?.breadTextField.text = String(describing: round(value * 10) / 10)
        }

        breadSlider.addAction(changeValueAction, for: .valueChanged)
        breadSlider.snp.makeConstraints { make in
            make.top.equalTo(breadTextField.snp_bottomMargin).offset(15)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpInsulinLabel() {
        addSubview(insulinLabel)
        insulinLabel.text = "Итоговое количество инсулина"
        insulinLabel.font = UIFont.systemFont(ofSize: 16)
        insulinLabel.textColor = .lightGray

        insulinLabel.snp.makeConstraints { make in
            make.top.equalTo(breadSlider.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
    }

    private func setUpInsulinTextField() {
        addSubview(insulinTextField)
        insulinTextField.textAlignment = .center
        insulinTextField.text = "0"
        insulinTextField.layer.cornerRadius = 10
        insulinTextField.keyboardType = .numbersAndPunctuation
        insulinTextField.layer.borderWidth = 1
        insulinTextField.layer.borderColor = UIColor.lightGray.cgColor
        insulinTextField.backgroundColor = .white
        let changeAction = UIAction { [weak self] _ in
            if let text = self?.insulinTextField.text, let value = Float(text) {
                self?.insulinSlider.value = value
            }
        }
        insulinTextField.addAction(changeAction, for: .editingChanged)
        insulinTextField.snp.makeConstraints { make in
            make.top.equalTo(insulinLabel.snp_bottomMargin).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(36)
        }
    }

    private func setUpInsulinSlider() {
        insulinSlider.minimumTrackTintColor = .mainApp
        insulinSlider.maximumValue = 30
        insulinSlider.minimumValue = 0
        addSubview(insulinSlider)
        insulinSlider.maximumTrackTintColor = .mainApp.withAlphaComponent(0.2)
        insulinSlider.thumbTintColor = .mainApp
        insulinSlider.value = 0

        insulinSlider.setThumbImage(UIImage.sliderThumbIcon, for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.insulinSlider.value else { return }
            self?.insulinTextField.text = String(describing: round(value * 10) / 10)
        }
        insulinSlider.addAction(changeValueAction, for: .valueChanged)

        insulinSlider.snp.makeConstraints { make in
            make.top.equalTo(insulinTextField.snp_bottomMargin).offset(15)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }
}
