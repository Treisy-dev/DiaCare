//
//  NewNoteFoodSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.03.2024.
//
import SnapKit
import UIKit

final class NewNoteFoodSubView: UIView {

    private lazy var foodLabel: UILabel = UILabel()
    private lazy var foodVStack: UIStackView = UIStackView()
    private lazy var addFoodButton: CustomAddFoodButton = CustomAddFoodButton(frame: frame, title: "Добавить продукт")

    var addProductTapped: (() -> Void)?

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
        setUpFoodLabel()
        setUpAddFoodButton()
        setUpFoodVStack()
    }

    private func setUpFoodLabel() {
        addSubview(foodLabel)
        foodLabel.text = "Питание"
        foodLabel.font = UIFont.boldSystemFont(ofSize: 16)
        foodLabel.textColor = .black
        foodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }

    private func setUpFoodVStack() {
        addSubview(foodVStack)
        foodVStack.axis = .vertical
        foodVStack.spacing = 10
        foodVStack.alignment = .center

        foodVStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(addFoodButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(30)
        }
    }

    private func setUpAddFoodButton() {
        addSubview(addFoodButton)
        let addProductAction: UIAction = UIAction { [weak self] _ in
            self?.addProductTapped?()
        }
        addFoodButton.addAction(addProductAction, for: .touchUpInside)
        addFoodButton.snp.makeConstraints { make in
            make.top.equalTo(foodLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
}
