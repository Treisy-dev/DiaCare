//
//  NewNoteInjectionSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 16.03.2024.
//

import SnapKit
import UIKit

final class NewNoteInjectionSubView: UIView {

    lazy var breadSlider: UISlider = UISlider()
    lazy var breadTextField: UITextField = UITextField()
    lazy var shortInsulinSlider: UISlider = UISlider()
    lazy var shortInsulinTextField: UITextField = UITextField()
    lazy var longInsulinSlider: UISlider = UISlider()
    lazy var longInsulinTextField: UITextField = UITextField()

    private lazy var breadLabel: UILabel = UILabel()
    private lazy var shortInsulinLabel: UILabel = UILabel()
    private lazy var longInsulinLabel: UILabel = UILabel()

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
        setUpShortInsulinLabel()
        setUpShortInsulinTextField()
        setUpShortInsulinSlider()
        setUpLongInsulinLabel()
        setUpLongInsulinTextField()
        setUpLongInsulinSlider()
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
            make.top.equalTo(breadLabel.snp.bottom).offset(10)
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
            make.top.equalTo(breadTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpShortInsulinLabel() {
        addSubview(shortInsulinLabel)
        shortInsulinLabel.text = "Количество короткого инсулина"
        shortInsulinLabel.font = UIFont.systemFont(ofSize: 16)
        shortInsulinLabel.textColor = .lightGray

        shortInsulinLabel.snp.makeConstraints { make in
            make.top.equalTo(breadSlider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
    }

    private func setUpShortInsulinTextField() {
        addSubview(shortInsulinTextField)
        shortInsulinTextField.textAlignment = .center
        shortInsulinTextField.text = "0"
        shortInsulinTextField.layer.cornerRadius = 10
        shortInsulinTextField.keyboardType = .numbersAndPunctuation
        shortInsulinTextField.layer.borderWidth = 1
        shortInsulinTextField.layer.borderColor = UIColor.lightGray.cgColor
        shortInsulinTextField.backgroundColor = .white
        let changeAction = UIAction { [weak self] _ in
            if let text = self?.shortInsulinTextField.text, let value = Float(text) {
                self?.shortInsulinSlider.value = value
            }
        }
        shortInsulinTextField.addAction(changeAction, for: .editingChanged)
        shortInsulinTextField.snp.makeConstraints { make in
            make.top.equalTo(shortInsulinLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(36)
        }
    }

    private func setUpShortInsulinSlider() {
        shortInsulinSlider.minimumTrackTintColor = .mainApp
        shortInsulinSlider.maximumValue = 30
        shortInsulinSlider.minimumValue = 0
        addSubview(shortInsulinSlider)
        shortInsulinSlider.maximumTrackTintColor = .mainApp.withAlphaComponent(0.2)
        shortInsulinSlider.thumbTintColor = .mainApp
        shortInsulinSlider.value = 0

        shortInsulinSlider.setThumbImage(UIImage.sliderThumbIcon, for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.shortInsulinSlider.value else { return }
            self?.shortInsulinTextField.text = String(describing: round(value * 10) / 10)
        }
        shortInsulinSlider.addAction(changeValueAction, for: .valueChanged)

        shortInsulinSlider.snp.makeConstraints { make in
            make.top.equalTo(shortInsulinTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpLongInsulinLabel() {
        addSubview(longInsulinLabel)
        longInsulinLabel.text = "Количество продленного инсулина"
        longInsulinLabel.font = UIFont.systemFont(ofSize: 16)
        longInsulinLabel.textColor = .lightGray

        longInsulinLabel.snp.makeConstraints { make in
            make.top.equalTo(shortInsulinSlider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
    }

    private func setUpLongInsulinTextField() {
        addSubview(longInsulinTextField)
        longInsulinTextField.textAlignment = .center
        longInsulinTextField.text = "0"
        longInsulinTextField.layer.cornerRadius = 10
        longInsulinTextField.keyboardType = .numbersAndPunctuation
        longInsulinTextField.layer.borderWidth = 1
        longInsulinTextField.layer.borderColor = UIColor.lightGray.cgColor
        longInsulinTextField.backgroundColor = .white
        let changeAction = UIAction { [weak self] _ in
            if let text = self?.longInsulinTextField.text, let value = Float(text) {
                self?.longInsulinSlider.value = value
            }
        }
        longInsulinTextField.addAction(changeAction, for: .editingChanged)
        longInsulinTextField.snp.makeConstraints { make in
            make.top.equalTo(longInsulinLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(36)
        }
    }

    private func setUpLongInsulinSlider() {
        longInsulinSlider.minimumTrackTintColor = .mainApp
        longInsulinSlider.maximumValue = 30
        longInsulinSlider.minimumValue = 0
        addSubview(longInsulinSlider)
        longInsulinSlider.maximumTrackTintColor = .mainApp.withAlphaComponent(0.2)
        longInsulinSlider.thumbTintColor = .mainApp
        longInsulinSlider.value = 0

        longInsulinSlider.setThumbImage(UIImage.sliderThumbIcon, for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.longInsulinSlider.value else { return }
            self?.longInsulinTextField.text = String(describing: round(value * 10) / 10)
        }
        longInsulinSlider.addAction(changeValueAction, for: .valueChanged)

        longInsulinSlider.snp.makeConstraints { make in
            make.top.equalTo(longInsulinTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }
}
