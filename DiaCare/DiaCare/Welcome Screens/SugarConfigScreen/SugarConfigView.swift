//
//  SugarConfigView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//
import SnapKit
import UIKit

protocol SugarConfigViewDelegate: AnyObject {
    func didPressNext(lowSugar: String?, targetSugar: String?, hightSugar: String?)
}

class SugarConfigView: UIView {
    lazy var welcomeImageView: UIImageView = UIImageView()
    lazy var configLabel: UILabel = UILabel()
    lazy var lowSugarField: CustomConfigTextField = CustomConfigTextField(
        frame: frame,
        icon: UIImage.bloodIcon,
        placeholder: "Выберете низкий сахар")
    lazy var targetSugarField: CustomConfigTextField = CustomConfigTextField(
        frame: frame,
        icon: UIImage.targetIcon,
        placeholder: "Выберете целевой сахар")
    lazy var hightSugarField: CustomConfigTextField = CustomConfigTextField(
        frame: frame,
        icon: UIImage.bloodIcon,
        placeholder: "Выберете высокий сахар")
    lazy var pickerView: UIPickerView = UIPickerView()
    lazy var nextButton: UIButton = UIButton()

    weak var delegate: SugarConfigViewDelegate?

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
        setUpLowSugarTextField()
        setUpTargetSugarTextField()
        setUpHightSugarTextField()
        setUpNextButton()
    }

    private func setUpWelcomeImageView() {
        addSubview(welcomeImageView)
        welcomeImageView.image = UIImage(named: "WelcomeImage2")
        welcomeImageView.snp.makeConstraints { make in
            make.width.equalTo(393)
            make.height.equalTo(340)
            make.top.equalTo(117)
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

    private func setUpLowSugarTextField() {
        addSubview(lowSugarField)
        lowSugarField.text = "4.0"
        lowSugarField.inputView = pickerView
        setPickerDoneButton(textField: lowSugarField)

        lowSugarField.snp.makeConstraints { make in
            make.top.equalTo(configLabel.snp_bottomMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
    }

    private func setUpTargetSugarTextField() {
        addSubview(targetSugarField)

        targetSugarField.text = "7.0"
        targetSugarField.inputView = pickerView
        setPickerDoneButton(textField: targetSugarField)

        targetSugarField.snp.makeConstraints { make in
            make.top.equalTo(lowSugarField.snp_bottomMargin).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
    }

    private func setUpHightSugarTextField() {
        addSubview(hightSugarField)

        hightSugarField.text = "10.0"
        hightSugarField.inputView = pickerView
        setPickerDoneButton(textField: hightSugarField)

        hightSugarField.snp.makeConstraints { make in
            make.top.equalTo(targetSugarField.snp_bottomMargin).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
    }

    private func setUpNextButton() {
        addSubview(nextButton)
        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = UIColor.mainApp
        nextButton.layer.cornerRadius = 18
        let nextAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didPressNext(
                lowSugar: self?.lowSugarField.text,
                targetSugar: self?.targetSugarField.text,
                hightSugar: self?.hightSugarField.text)
        }
        nextButton.addAction(nextAction, for: .touchUpInside)

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(hightSugarField.snp_bottomMargin).offset(40)
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
}
