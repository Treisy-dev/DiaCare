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
    lazy var teamScoreLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpProductImageView()
        setUpProductInfoVStack()
        setUpProductLabel()
        setUpProductPropsHStack()
    }

    func config(
        productName: String,
        productImage: UIImage,
        proteinCount: String,
        fatCount: String,
        carbCount: String) {
            productLabel.text = productName
            productImageView.image = productImage
            proteinVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Белки",
                titleLabelColor: .systemYellow,
                count: proteinCount)
            fatVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Жиры",
                titleLabelColor: .systemBlue,
                count: fatCount)
            carbohydratesVStack = ProductVStackFabric.shared.makeProductPropVStack(
                titleLabel: "Углеводы",
                titleLabelColor: .systemRed,
                count: carbCount)
            guard let proteinVStack, let fatVStack, let carbohydratesVStack else { return }
            productPropsHStack.addArrangedSubview(proteinVStack)
            productPropsHStack.addArrangedSubview(fatVStack)
            productPropsHStack.addArrangedSubview(carbohydratesVStack)
    }

    private func setUpProductImageView() {
        addSubview(productImageView)
        productImageView.contentMode = .center

        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(-5)
            make.width.equalTo(40)
        }
    }

    private func setUpProductInfoVStack() {
        addSubview(productInfoVStack)
        productInfoVStack.axis = .vertical
        productInfoVStack.alignment = .center
        productInfoVStack.spacing = 0
        productInfoVStack.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(productImageView.snp.trailing)
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

    private func setUpProductPropsHStack() {
        productInfoVStack.addArrangedSubview(productPropsHStack)
        productPropsHStack.axis = .horizontal
        productPropsHStack.distribution = .equalSpacing
    }
}
