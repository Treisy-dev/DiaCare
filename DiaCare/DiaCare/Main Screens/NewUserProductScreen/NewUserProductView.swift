//
//  NewUserProductView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.04.2024.
//
import SnapKit
import UIKit

final class NewUserProductView: UIView {

    lazy var categoryTextField: UITextField = UITextField()
    lazy var categoryPickerView: UIPickerView = UIPickerView()
    lazy var productNameTextField: UITextField = UITextField()
    lazy var proteinInputView = NewProductInputView(frame: .zero, title: "Количество белков на 100гр")
    lazy var fatInputView = NewProductInputView(frame: .zero, title: "Количество жиров на 100гр")
    lazy var carbsInputView = NewProductInputView(frame: .zero, title: "Количество углеводов на 100гр")
    var closeAction: (() -> Void)?
    var addAction: (() -> Void)?

    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var newProductImageView: UIImageView = UIImageView()
    private lazy var newProductContentView: UIView = UIView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var productNameLabel: UILabel = UILabel()
    private lazy var addButton: UIButton = UIButtonFabric.shared.makeAddButton()
    private lazy var closeButton: UIButton = UIButtonFabric.shared.makeCloseButton()
    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if panGestureRecognizer == nil {
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            guard let panGestureRecognizer else {return}
            newProductContentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = newProductContentView.frame.maxY
            initialTransform = newProductContentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 850 && newMaxY >= 770 {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                newProductContentView.transform = newTransform
            }
        }
    }

    private func setUp() {
        setUpGradientView()
        setUpNewProductImageView()
        setUpNewProductContentView()
        setUpTitleLable()
        setUpCategoryTextField()
        setUpProductNameLabel()
        setUpProductNameTextField()
        setUpProteinInputView()
        setUpFatInputView()
        setUpCarbsInputView()
        setUpAddButton()
        setUpCloseButton()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }

    private func setUpNewProductImageView() {
        gradientView.addSubview(newProductImageView)
        newProductImageView.image = UIImage.newProduct
        newProductImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setUpNewProductContentView() {
        addSubview(newProductContentView)
        newProductContentView.layer.cornerRadius = 40
        newProductContentView.backgroundColor = .white
        newProductContentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(250)
            make.height.equalTo(600)
        }
    }

    private func setUpTitleLable() {
        newProductContentView.addSubview(titleLable)
        titleLable.text = "Добавление продукта"
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textAlignment = .center
        titleLable.textColor = .black

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpCategoryTextField() {
        newProductContentView.addSubview(categoryTextField)
        categoryTextField.inputView = categoryPickerView
        categoryTextField.layer.cornerRadius = 10
        categoryTextField.layer.borderWidth = 1
        categoryTextField.layer.borderColor = UIColor.mainApp.cgColor
        categoryTextField.textAlignment = .center
        categoryTextField.text = "Продукт без категории"
        categoryTextField.textColor = .mainApp
        setPickerDoneButton(textField: categoryTextField)

        let arrowImageView: UIImageView = UIImageView()
        categoryTextField.addSubview(arrowImageView)
        arrowImageView.image = UIImage.downArrayMain
        arrowImageView.contentMode = .center

        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
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

    private func setUpProductNameLabel() {
        newProductContentView.addSubview(productNameLabel)
        productNameLabel.text = "Наименование продукта"
        productNameLabel.font = UIFont.systemFont(ofSize: 16)
        productNameLabel.textColor = .lightGray

        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
        }
    }

    private func setUpProductNameTextField() {
        newProductContentView.addSubview(productNameTextField)
        productNameTextField.layer.cornerRadius = 10
        productNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        productNameTextField.layer.borderWidth = 1
        productNameTextField.textAlignment = .center

        productNameTextField.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
    }

    private func setUpProteinInputView() {
        newProductContentView.addSubview(proteinInputView)
        proteinInputView.snp.makeConstraints { make in
            make.top.equalTo(productNameTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }

    private func setUpFatInputView() {
        newProductContentView.addSubview(fatInputView)
        fatInputView.snp.makeConstraints { make in
            make.top.equalTo(proteinInputView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }

    private func setUpCarbsInputView() {
        newProductContentView.addSubview(carbsInputView)
        carbsInputView.snp.makeConstraints { make in
            make.top.equalTo(fatInputView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }

    private func setUpAddButton() {
        newProductContentView.addSubview(addButton)
        let addAction: UIAction = UIAction { [weak self] _ in
            self?.addButton.addAlphaAnimation()
            self?.addAction?()
        }
        addButton.addAction(addAction, for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(carbsInputView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }

    private func setUpCloseButton() {
        newProductContentView.addSubview(closeButton)
        let closeAction: UIAction = UIAction { [weak self] _ in
            self?.closeButton.addAlphaAnimation()
            self?.closeAction?()
        }
        closeButton.addAction(closeAction, for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(carbsInputView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
}
