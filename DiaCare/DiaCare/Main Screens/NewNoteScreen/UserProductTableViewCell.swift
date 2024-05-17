//
//  UserProductTableViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.04.2024.
//
import SnapKit
import UIKit

final class UserProductTableViewCell: UITableViewCell {
    private lazy var productImageView: UIImageView = UIImageView()
    private lazy var borderView: UIView = UIView()
    private lazy var verticalSeparateView: UIView = UIView()
    private lazy var horizontalSeparateView: UIView = UIView()
    private lazy var productLabel: UILabel = UILabel()
    private lazy var productInfoVStack: UIStackView = UIStackView()
    private lazy var productPropsHStack: UIStackView = UIStackView()
    private var proteinVStack: UIStackView?
    private var fatVStack: UIStackView?
    private var carbohydratesVStack: UIStackView?
    private var grammsVStack: UIStackView?
    private var breadCountVStack: UIStackView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(
        productName: String,
        productCategory: ProductCategories,
        proteinCount: String,
        productStats: (fat: String, carb: String, breadCount: String)) {
            productLabel.text = productName
            productImageView.image = productCategory.getImageByType()
            proteinVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Белки",
                titleLabelColor: .systemYellow,
                count: proteinCount)
            fatVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Жиры",
                titleLabelColor: .systemBlue,
                count: productStats.fat)
            carbohydratesVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Углеводы",
                titleLabelColor: .systemRed,
                count: productStats.carb)
            breadCountVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "ХЕ",
                titleLabelColor: .systemGreen,
                count: productStats.breadCount)
            guard let proteinVStack, let fatVStack, let carbohydratesVStack, let breadCountVStack else { return }
            productPropsHStack.addArrangedSubview(proteinVStack)
            productPropsHStack.addArrangedSubview(fatVStack)
            productPropsHStack.addArrangedSubview(carbohydratesVStack)
            productPropsHStack.addArrangedSubview(breadCountVStack)
        }

    func configTemplate(
        productName: String,
        templateCategory: TemplateCategories,
        proteinCount: String,
        productStats: (fat: String, carb: String, breadCount: String)) {
            productLabel.text = productName
            productImageView.image = templateCategory.getImageByType()
            proteinVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Белки",
                titleLabelColor: .systemYellow,
                count: proteinCount)
            fatVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Жиры",
                titleLabelColor: .systemBlue,
                count: productStats.fat)
            carbohydratesVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Углеводы",
                titleLabelColor: .systemRed,
                count: productStats.carb)
            breadCountVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "ХЕ",
                titleLabelColor: .systemGreen,
                count: productStats.breadCount)
            guard let proteinVStack, let fatVStack, let carbohydratesVStack, let breadCountVStack else { return }
            productPropsHStack.addArrangedSubview(proteinVStack)
            productPropsHStack.addArrangedSubview(fatVStack)
            productPropsHStack.addArrangedSubview(carbohydratesVStack)
            productPropsHStack.addArrangedSubview(breadCountVStack)
        }

    private func setUp() {
        setUpBorderView()
        setUpProductImageView()
        setUpVerticalSeparateView()
        setUpProductInfoVStack()
        setUpProductLabel()
        setUpHorizontalSeparateView()
        setUpProductPropsHStack()
    }

    private func setUpBorderView() {
        addSubview(borderView)
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }

    private func setUpProductImageView() {
        borderView.addSubview(productImageView)
        productImageView.contentMode = .center

        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(-5)
            make.width.equalTo(40)
        }
    }

    private func setUpVerticalSeparateView() {
        borderView.addSubview(verticalSeparateView)
        verticalSeparateView.backgroundColor = .lightGray
        verticalSeparateView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.equalTo(productImageView.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpProductInfoVStack() {
        borderView.addSubview(productInfoVStack)
        productInfoVStack.axis = .vertical
        productInfoVStack.alignment = .center
        productInfoVStack.spacing = 0
        productInfoVStack.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(verticalSeparateView.snp.trailing)
        }
    }

    private func setUpProductLabel() {
        productInfoVStack.addArrangedSubview(productLabel)
        productLabel.adjustsFontSizeToFitWidth = true
        productLabel.minimumScaleFactor = 0.5
        productLabel.textAlignment = .center
        productLabel.font = UIFont.systemFont(ofSize: 20)
        productLabel.textColor = .black
    }

    private func setUpHorizontalSeparateView() {
        productInfoVStack.addArrangedSubview(horizontalSeparateView)
        horizontalSeparateView.backgroundColor = .lightGray
        horizontalSeparateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    private func setUpProductPropsHStack() {
        productInfoVStack.addArrangedSubview(productPropsHStack)
        productPropsHStack.axis = .horizontal
        productPropsHStack.alignment = .center
        productPropsHStack.distribution = .equalSpacing

        productPropsHStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
