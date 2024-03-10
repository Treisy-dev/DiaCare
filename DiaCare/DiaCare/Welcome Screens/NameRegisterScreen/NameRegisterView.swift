//
//  NameRegisterView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//
import SnapKit
import UIKit

protocol NameRegisterViewDelegate: AnyObject {
    func didPressNext(name: String?, email: String?)
}

class NameRegisterView: UIView {
    lazy var welcomeImageView: UIImageView = UIImageView()
    lazy var registerLabel: UILabel = UILabel()
    lazy var nameTextField: UITextField = UITextField()
    lazy var emailTextField: UITextField = UITextField()
    lazy var nextButton: UIButton = UIButton()

    weak var delegate: NameRegisterViewDelegate?
    var showAlert: ( () -> Void)?

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
        setUpRegisterLabel()
        setUpNameTextField()
        setUpEmailTextField()
        setUpNextButton()
    }

    private func setUpWelcomeImageView() {
        addSubview(welcomeImageView)
        welcomeImageView.image = UIImage(named: "WelcomeImage1")
        welcomeImageView.snp.makeConstraints { make in
            make.size.equalTo(400)
            make.top.equalTo(108)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpRegisterLabel() {
        addSubview(registerLabel)
        registerLabel.text = "Регистрация"
        registerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        registerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeImageView.snp_bottomMargin).offset(20)
        }
    }

    private func setUpNameTextField() {
        addSubview(nameTextField)
        nameTextField.placeholder = "Введите имя"
        nameTextField.delegate = self
        nameTextField.returnKeyType = .next
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        nameTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.size.height))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always

        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(60)
            make.top.equalTo(registerLabel.snp_bottomMargin).offset(50)
        }
    }

    private func setUpEmailTextField() {
        addSubview(emailTextField)
        emailTextField.placeholder = "Введите почту"
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        emailTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.size.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always

        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(60)
            make.top.equalTo(nameTextField.snp_bottomMargin).offset(30)
        }
    }

    private func setUpNextButton() {
        addSubview(nextButton)
        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = UIColor.mainApp
        nextButton.layer.cornerRadius = 18
        let nextAction: UIAction = UIAction { [weak self] _ in
            if self?.checkFields() == true {
                self?.delegate?.didPressNext(name: self?.nameTextField.text, email: self?.emailTextField.text)
            } else {
                self?.showAlert?()
            }
        }
        nextButton.addAction(nextAction, for: .touchUpInside)

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp_bottomMargin).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(80)
        }
    }

    private func checkFields() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty else {
            return false
        }

        return true
    }
}

extension NameRegisterView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            if checkFields() == true {
                delegate?.didPressNext(name: nameTextField.text, email: emailTextField.text)
            } else {
                showAlert?()
            }
        default: break
        }

        return true
    }
}
