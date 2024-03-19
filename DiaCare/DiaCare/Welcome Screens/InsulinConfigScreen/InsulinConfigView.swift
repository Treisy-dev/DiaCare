//
//  InsulinConfigView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//
import SnapKit
import UIKit

protocol InsulinConfigViewDelegate: AnyObject {
    func didPressSave(shortInsulin: String?, longInsulin: String?)
    func didPressBack()
}

final class InsulinConfigView: UIView {
    lazy var welcomeImageView: UIImageView = UIImageView()
    lazy var configLabel: UILabel = UILabel()
    lazy var shortInsulinField: CustomConfigTextField = CustomConfigTextField(
        frame: frame,
        icon: UIImage.shortInsulinIcon,
        placeholder: "Короткий инсулин")
    lazy var longInsulinField: CustomConfigTextField = CustomConfigTextField(
        frame: frame,
        icon: UIImage.longInsulinIcon,
        placeholder: "Продленный инсулин")
    lazy var shortPickerView: UIPickerView = UIPickerView()
    lazy var longPickerView: UIPickerView = UIPickerView()
    lazy var saveButton: UIButton = UIButton()
    lazy var backButton: UIButton = UIButton()

    weak var delegate: InsulinConfigViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpWelcomeImageView()
        setUpConfigLabel()
        setUpShortInsulinTextField()
        setUpLongInsulinTextField()
        setUpNextButton()
        setUpBackButton()
    }

    private func setUpWelcomeImageView() {
        addSubview(welcomeImageView)
        welcomeImageView.image = UIImage(named: "WelcomeImage4")
        welcomeImageView.snp.makeConstraints { make in
            make.width.equalTo(393)
            make.height.equalTo(440)
            make.top.equalTo(75)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpConfigLabel() {
        addSubview(configLabel)
        configLabel.text = "Настройка данных"
        configLabel.font = UIFont.boldSystemFont(ofSize: 24)
        configLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeImageView.snp_bottomMargin).offset(60)
        }
    }

    private func setUpShortInsulinTextField() {
        addSubview(shortInsulinField)
        shortInsulinField.inputView = shortPickerView
        setPickerDoneButton(textField: shortInsulinField)

        shortInsulinField.snp.makeConstraints { make in
            make.top.equalTo(configLabel.snp_bottomMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
    }

    private func setUpLongInsulinTextField() {
        addSubview(longInsulinField)

        longInsulinField.inputView = longPickerView
        setPickerDoneButton(textField: longInsulinField)

        longInsulinField.snp.makeConstraints { make in
            make.top.equalTo(shortInsulinField.snp_bottomMargin).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
    }

    private func setUpNextButton() {
        addSubview(saveButton)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = UIColor.mainApp
        saveButton.layer.cornerRadius = 18
        let nextAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didPressSave(
                shortInsulin: self?.shortInsulinField.text,
                longInsulin: self?.longInsulinField.text)
        }
        saveButton.addAction(nextAction, for: .touchUpInside)

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(longInsulinField.snp_bottomMargin).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(80)
        }
    }

    private func setPickerDoneButton(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneAction: UIAction = UIAction { _ in
            textField.resignFirstResponder()
        }
        let doneButton = UIBarButtonItem(title: "Done", image: nil, primaryAction: doneAction, menu: nil)
        toolbar.setItems([doneButton], animated: true)
        toolbar.backgroundColor = .gray
        textField.inputAccessoryView = toolbar
    }

    private func setUpBackButton() {
        addSubview(backButton)
        backButton.layer.cornerRadius = 10
        backButton.setImage(UIImage.leftArrowIcon, for: .normal)
        let backAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didPressBack()
        }
        backButton.addAction(backAction, for: .touchUpInside)

        backButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().offset(70)
            make.leading.lessThanOrEqualToSuperview().offset(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}
