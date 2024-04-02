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
    private lazy var borderView: UIView = UIView()
    lazy var productLabel: UILabel = UILabel()
    lazy var productInfoVStack: UIStackView = UIStackView()
    lazy var productPropsHStack: UIStackView = UIStackView()
    var proteinVStack: UIStackView?
    var fatVStack: UIStackView?
    var carbohydratesVStack: UIStackView?
    lazy var teamScoreLabel: UILabel = UILabel()

    enum ProductCategories: String {
        case fruit
        case vegetable
        case cereal
        case fish
        case meat
        case none

        func getImageByType() -> UIImage {
            switch self {
            case .fruit:
                return UIImage.fruit.resizeImage(newSize: CGSize(width: 45, height: 45))
            case .vegetable:
                return UIImage.vegetable.resizeImage(newSize: CGSize(width: 45, height: 45))
            case .cereal:
                return UIImage.cereal.resizeImage(newSize: CGSize(width: 45, height: 45))
            case .fish:
                return UIImage.fish.resizeImage(newSize: CGSize(width: 45, height: 45))
            case .meat:
                return UIImage.meat.resizeImage(newSize: CGSize(width: 45, height: 45))
            case .none:
                return UIImage.lunch.resizeImage(newSize: CGSize(width: 45, height: 45))
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBorderView()
        setUpProductImageView()
        setUpProductInfoVStack()
        setUpProductLabel()
        setUpProductPropsHStack()
    }

    func config(
        productName: String,
        productCategory: ProductCategories,
        proteinCount: String,
        fatCount: String,
        carbCount: String) {
            productLabel.text = productName
            productImageView.image = productCategory.getImageByType()
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

    func getCategoryFromString(_ categoryString: String) -> ProductCategories {
        if let category = ProductCategories(rawValue: categoryString) {
            return category
        } else {
            return .none
        }
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
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(-5)
            make.width.equalTo(40)
        }
    }

    private func setUpProductInfoVStack() {
        borderView.addSubview(productInfoVStack)
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
        productPropsHStack.spacing = 10
    }
}
