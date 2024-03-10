//
//  FoodConfigView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//
import SnapKit
import UIKit

protocol FoodConfigViewDelegate: AnyObject {
    func didPressNext(breadCount: String?, insulinCount: String?)
}

class FoodConfigView: UIView {
    lazy var welcomeImageView: UIImageView = UIImageView()
    lazy var configLabel: UILabel = UILabel()
    lazy var breadCountLabel: UILabel = UILabel()
    lazy var breadSegmentControl: UISegmentedControl = UISegmentedControl(items: ["10", "12"])
    lazy var insulinCountLabel: UILabel = UILabel()
    lazy var insulinTextField: UITextField = UITextField()
    lazy var pickerView: UIPickerView = UIPickerView()
    lazy var nextButton: UIButton = UIButton()

    weak var delegate: FoodConfigViewDelegate?

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
        setUpBreadCountLable()
        setUpBreadSegmentControl()
        setUpInsulinCountLable()
        setUpInsulinTextField()
        setUpNextButton()
    }

    private func setUpWelcomeImageView() {
        addSubview(welcomeImageView)
        welcomeImageView.image = UIImage(named: "WelcomeImage3")
        welcomeImageView.snp.makeConstraints { make in
            make.height.equalTo(480)
            make.width.equalTo(393)
            make.top.equalTo(62)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpConfigLabel() {
        addSubview(configLabel)
        configLabel.text = "Настройка данных"
        configLabel.font = UIFont.boldSystemFont(ofSize: 24)
        configLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeImageView.snp_bottomMargin).offset(30)
        }
    }

    private func setUpBreadCountLable() {
        addSubview(breadCountLabel)

        breadCountLabel.text = "Кол-во углеводов в ХЕ"
        breadCountLabel.font = UIFont.systemFont(ofSize: 16)

        breadCountLabel.snp.makeConstraints { make in
            make.top.equalTo(configLabel.snp_bottomMargin).offset(34)
            make.leading.lessThanOrEqualToSuperview().offset(65)
        }
    }

    private func setUpBreadSegmentControl() {
        addSubview(breadSegmentControl)

        breadSegmentControl.selectedSegmentIndex = 0
        breadSegmentControl.tintColor = .mainApp

        let font = UIFont.systemFont(ofSize: 16)
        breadSegmentControl.selectedSegmentTintColor = .mainApp
        breadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.mainApp, .font: font], for: .normal)
        breadSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: font], for: .selected)

        breadSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(configLabel.snp_bottomMargin).offset(30)
            make.trailing.lessThanOrEqualToSuperview().offset(50)
            make.leading.lessThanOrEqualTo(breadCountLabel.snp_trailingMargin).offset(20)
        }
    }

    private func setUpInsulinCountLable() {
        addSubview(insulinCountLabel)

        insulinCountLabel.text = "Кол-во инсулина на ХЕ"
        insulinCountLabel.font = UIFont.systemFont(ofSize: 16)

        insulinCountLabel.snp.makeConstraints { make in
            make.top.equalTo(breadCountLabel.snp_bottomMargin).offset(40)
            make.leading.lessThanOrEqualToSuperview().offset(65)
        }
    }

    private func setUpInsulinTextField() {
        addSubview(insulinTextField)

        insulinTextField.text = "1.0"
        insulinTextField.textColor = .mainApp
        insulinTextField.layer.cornerRadius = 10
        insulinTextField.layer.borderColor = UIColor.mainApp.cgColor
        insulinTextField.layer.borderWidth = 1
        insulinTextField.textAlignment = .center
        insulinTextField.font = UIFont.systemFont(ofSize: 16)

        insulinTextField.inputView = pickerView

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneAction: UIAction = UIAction { [weak self] _ in
            self?.insulinTextField.resignFirstResponder()
        }
        let doneButton = UIBarButtonItem(title: "Done", image: nil, primaryAction: doneAction, menu: nil)
        toolbar.setItems([doneButton], animated: true)
        toolbar.backgroundColor = .gray
        insulinTextField.inputAccessoryView = toolbar

        insulinTextField.snp.makeConstraints { make in
            make.top.equalTo(breadSegmentControl.snp_bottomMargin).offset(32)
            make.width.equalTo(68)
            make.trailing.lessThanOrEqualToSuperview().offset(50)
            make.leading.lessThanOrEqualTo(insulinCountLabel.snp_trailingMargin).offset(20)
        }
    }

    private func setUpNextButton() {
        addSubview(nextButton)
        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = UIColor.mainApp
        nextButton.layer.cornerRadius = 18
        let nextAction: UIAction = UIAction { [weak self] _ in
            guard let breadCountIndex = self?.breadSegmentControl.selectedSegmentIndex else { return }
            guard let breadCount = (self?.breadSegmentControl.titleForSegment(at: breadCountIndex))
                else { return }
            self?.delegate?.didPressNext(
                breadCount: breadCount,
                insulinCount: self?.insulinTextField.text)
        }
        nextButton.addAction(nextAction, for: .touchUpInside)

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(insulinCountLabel.snp_bottomMargin).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(80)
        }
    }
}
