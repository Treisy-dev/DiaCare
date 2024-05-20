//
//  ProductTableViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 28.03.2024.
//
import SnapKit
import UIKit

final class ProductTableViewCell: UITableViewCell {

    lazy var productImageView: UIImageView = UIImageView()
    lazy var productLabel: UILabel = UILabel()
    lazy var productInfoVStack: UIStackView = UIStackView()
    lazy var productPropsHStack: UIStackView = UIStackView()
    var proteinVStack: UIStackView?
    var fatVStack: UIStackView?
    var carbohydratesVStack: UIStackView?

    private lazy var borderView: UIView = UIView()
    private lazy var verticalSeparateView: UIView = UIView()
    private lazy var horizontalSeparateView: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(
        productName: String,
        productCategory: ProductCategories,
        proteinCount: String,
        fatCount: String,
        carbCount: String
    ) {
        productLabel.text = productName
        productImageView.image = productCategory.getImageByType()
        proteinVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "Белки",
            titleLabelColor: .systemYellow,
            count: proteinCount
        )
        fatVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "Жиры",
            titleLabelColor: .systemBlue,
            count: fatCount
        )
        carbohydratesVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "Углеводы",
            titleLabelColor: .systemRed,
            count: carbCount
        )
        guard let proteinVStack, let fatVStack, let carbohydratesVStack else { return }
        productPropsHStack.addArrangedSubview(proteinVStack)
        productPropsHStack.addArrangedSubview(fatVStack)
        productPropsHStack.addArrangedSubview(carbohydratesVStack)
    }

    func configTemplate(
        productName: String,
        templateCategory: TemplateCategories,
        breadCount: String,
        insulinCount: String,
        carbCount: String
    ) {
        productLabel.text = productName
        productImageView.image = templateCategory.getImageByType()
        proteinVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "ХЕ",
            titleLabelColor: .systemBlue,
            count: breadCount
        )
        fatVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "Инсулин",
            titleLabelColor: .purple,
            count: insulinCount
        )
        carbohydratesVStack = ProductVStackFabric.shared.makeProductPropVStack(
            titleLabel: "Углеводы",
            titleLabelColor: .systemRed,
            count: carbCount
        )
        guard let proteinVStack, let fatVStack, let carbohydratesVStack else { return }
        productPropsHStack.addArrangedSubview(proteinVStack)
        productPropsHStack.addArrangedSubview(fatVStack)
        productPropsHStack.addArrangedSubview(carbohydratesVStack)
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
        productPropsHStack.spacing = 10
    }
}
