//
//  NewTemplateFoodSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class NewTemplateFoodSubView: UIView {

    lazy var foodTableView: UITableView = UITableView()
    var addProductTapped: (() -> Void)?

    private lazy var foodLabel: UILabel = UILabel()
    private lazy var addFoodButton: CustomAddFoodButton = CustomAddFoodButton(frame: frame, title: "Добавить блюдо")

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpFoodLabel()
        setUpAddFoodButton()
        setUpFoodTableView()
    }

    private func setUpFoodLabel() {
        addSubview(foodLabel)
        foodLabel.text = "Добавленные блюда"
        foodLabel.textColor = .systemGray
        foodLabel.font = UIFont.systemFont(ofSize: 16)
        foodLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }

    private func setUpAddFoodButton() {
        addSubview(addFoodButton)
        let addProductAction: UIAction = UIAction { [weak self] _ in
            self?.addFoodButton.addAlphaAnimation()
            self?.addProductTapped?()
        }
        addFoodButton.addAction(addProductAction, for: .touchUpInside)
        addFoodButton.snp.makeConstraints { make in
            make.top.equalTo(foodLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }

    private func setUpFoodTableView() {
        addSubview(foodTableView)
        foodTableView.separatorStyle = .none
        foodTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().inset(-5)
            make.bottom.equalToSuperview()
            make.top.equalTo(addFoodButton.snp.bottom).offset(4)
        }
    }
}
