//
//  NewProductInputView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.04.2024.
//
import SnapKit
import UIKit

class NewProductInputView: UIView {

    private lazy var titleLabel: UILabel = UILabel()
    lazy var countTextField: UITextField = UITextField()
    lazy var countSlider: UISlider = UISlider()

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        titleLabel.text = title
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTitleLabel()
        setUpCountTextField()
        setUpCountSlider()
    }

    private func setUpTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .lightGray

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }

    private func setUpCountTextField() {
        addSubview(countTextField)
        countTextField.textAlignment = .center
        countTextField.text = "0"
        countTextField.textColor = .black
        countTextField.layer.cornerRadius = 10
        countTextField.keyboardType = .numbersAndPunctuation
        countTextField.layer.borderWidth = 1
        countTextField.layer.borderColor = UIColor.lightGray.cgColor
        countTextField.backgroundColor = .white
        let changeAction = UIAction { [weak self] _ in
            if let text = self?.countTextField.text, let value = Float(text) {
                self?.countSlider.value = value
            }
        }
        countTextField.addAction(changeAction, for: .editingChanged)

        countTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }

    private func setUpCountSlider() {
        addSubview(countSlider)
        countSlider.minimumTrackTintColor = .mainApp
        countSlider.maximumValue = 100
        countSlider.minimumValue = 0
        countSlider.maximumTrackTintColor = .mainApp.withAlphaComponent(0.2)
        countSlider.thumbTintColor = .mainApp
        countSlider.value = 0

        countSlider.setThumbImage(UIImage.sliderThumbIcon, for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.countSlider.value else { return }
            self?.countTextField.text = String(describing: round(value * 10) / 10)
        }

        countSlider.addAction(changeValueAction, for: .valueChanged)

        countSlider.snp.makeConstraints { make in
            make.top.equalTo(countTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
}
