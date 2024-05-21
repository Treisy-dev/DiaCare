//
//  NewTemplateView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class NewTemplateView: UIView {

    lazy var newTemplateContentView: UIView = UIView()
    lazy var nameTextField: UITextField = UITextField()
    lazy var categoryTextField: UITextField = UITextField()
    lazy var categoryPickerView: UIPickerView = UIPickerView()
    lazy var foodSubView: NewTemplateFoodSubView = NewTemplateFoodSubView(frame: .zero)
    lazy var injectionSubView: NewTemplateInjectionSubView = NewTemplateInjectionSubView(frame: .zero)
    lazy var statsSubView: NewTemplateStatsSubView = NewTemplateStatsSubView(frame: .zero)
    var saveTapped: (() -> Void)?
    var resetTapped: (() -> Void)?
    var scrollAddition: CGFloat = 0

    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var newTemplateImageView: UIImageView = UIImageView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var templateNameLabel: UILabel = UILabel()
    private lazy var categoryLabel: UILabel = UILabel()
    private lazy var resetButton: UIButton = UIButton()
    private lazy var saveButton: UIButton = UIButton()
    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?

    override func layoutSubviews() {
        super.layoutSubviews()

        if panGestureRecognizer == nil {
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            guard let panGestureRecognizer else {return}
            newTemplateContentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = newTemplateContentView.frame.maxY
            initialTransform = newTemplateContentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 930 + scrollAddition && newMaxY >= 770 - scrollAddition / 6 {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                newTemplateContentView.transform = newTransform
            }
        }
    }

    private func setUp() {
        setUpGradientView()
        setUpNewTemplateImageView()
        setUpNewTemplateContentView()
        setUpTitleLable()
        setUpTemplateNameLabel()
        setUpNameTextField()
        setUpCategoryLabel()
        setUpCategoryTextField()
        setUpFoodSubView()
        setUpInjectionSubView()
        setUpStatsSubView()
        setUpResetButton()
        setUpSaveButton()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }

    private func setUpNewTemplateImageView() {
        addSubview(newTemplateImageView)
        newTemplateImageView.image = UIImage.newTemplate
        newTemplateImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(89)
            make.leading.equalToSuperview().offset(89)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(209)
        }
    }

    private func setUpNewTemplateContentView() {
        addSubview(newTemplateContentView)
        newTemplateContentView.layer.cornerRadius = 40
        newTemplateContentView.backgroundColor = .white
        newTemplateContentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(newTemplateImageView.snp.bottom)
            make.height.equalTo(650)
        }
    }

    private func setUpTitleLable() {
        newTemplateContentView.addSubview(titleLable)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textColor = .black
        titleLable.text = "Настройки шаблона"

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpTemplateNameLabel() {
        newTemplateContentView.addSubview(templateNameLabel)
        templateNameLabel.text = "Название шаблона"
        templateNameLabel.font = UIFont.systemFont(ofSize: 16)
        templateNameLabel.textColor = .systemGray
        templateNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
        }
    }

    private func setUpNameTextField() {
        newTemplateContentView.addSubview(nameTextField)
        nameTextField.textAlignment = .center
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(templateNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }

    private func setUpCategoryLabel() {
        newTemplateContentView.addSubview(categoryLabel)
        categoryLabel.text = "Категория шаблона"
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        categoryLabel.textColor = .systemGray
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
        }
    }

    private func setUpCategoryTextField() {
        newTemplateContentView.addSubview(categoryTextField)
        categoryTextField.layer.cornerRadius = 10
        categoryTextField.text = "Завтрак"
        categoryTextField.layer.borderWidth = 1
        categoryTextField.layer.borderColor = UIColor.systemGray.cgColor
        categoryTextField.textAlignment = .center
        categoryTextField.inputView = categoryPickerView
        setPickerDoneButton(textField: categoryTextField)
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }

    private func setUpFoodSubView() {
        newTemplateContentView.addSubview(foodSubView)
        foodSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(categoryTextField.snp.bottom).offset(10)
            make.height.equalTo(70)
        }
    }

    private func setUpInjectionSubView() {
        newTemplateContentView.addSubview(injectionSubView)
        injectionSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(foodSubView.snp.bottom).offset(10)
            make.height.equalTo(145)
        }
    }

    private func setUpStatsSubView() {
        newTemplateContentView.addSubview(statsSubView)
        statsSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(injectionSubView.snp.bottom).offset(10)
            make.height.equalTo(90)
        }
    }

    private func setUpResetButton() {
        newTemplateContentView.addSubview(resetButton)
        resetButton.backgroundColor = .white
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.mainApp.cgColor
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.setTitleColor(.mainApp, for: .normal)
        let resetAction = UIAction { [weak self] _ in
            self?.resetTapped?()
        }

        resetButton.addAction(resetAction, for: .touchUpInside)

        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.top.equalTo(statsSubView.snp.bottom).offset(20)
            make.width.equalTo(158)
            make.height.equalTo(40)
        }
    }

    private func setUpSaveButton() {
        newTemplateContentView.addSubview(saveButton)
        saveButton.backgroundColor = .mainApp
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.mainApp.cgColor
        saveButton.setTitle("Добавить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)

        let saveButtonAction: UIAction = UIAction { [weak self] _ in
            self?.saveTapped?()
        }

        saveButton.addAction(saveButtonAction, for: .touchUpInside)

        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(33)
            make.leading.equalTo(resetButton.snp.trailing).offset(11)
            make.top.equalTo(statsSubView.snp.bottom).offset(20)
            make.height.equalTo(40)
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
