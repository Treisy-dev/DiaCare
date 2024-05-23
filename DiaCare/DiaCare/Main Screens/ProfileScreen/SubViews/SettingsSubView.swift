//
//  SettingsSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.03.2024.
//
import SnapKit
import UIKit

final class SettingsSubView: UIView {

    var customTextField: CustomLanguageTextField

    private lazy var settingsVStack: UIStackView = UIStackView()
    private lazy var settingsLable: UILabel = UILabel()

    init(frame: CGRect, selectedLanguage: String) {
        customTextField = CustomLanguageTextField(
            frame: frame,
            icon: .languageIcon,
            placeholder: selectedLanguage)
        super.init(frame: frame)
        setUpSettingsVStack()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSettingsVStack() {
        addSubview(settingsVStack)
        settingsVStack.axis = .vertical
        settingsVStack.spacing = 15

        settingsVStack.addArrangedSubview(settingsLable)
        settingsVStack.addArrangedSubview(customTextField)
        settingsLable.text = "Настройки:"
        settingsLable.font = UIFont.systemFont(ofSize: 16)
        settingsLable.textColor = .black

        settingsVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customTextField.text = "Русский"
        customTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
}
