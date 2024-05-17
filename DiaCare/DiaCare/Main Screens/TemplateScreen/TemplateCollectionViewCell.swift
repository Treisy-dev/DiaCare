//
//  TemplateCollectionViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class TemplateCollectionViewCell: UICollectionViewCell {

    var products: [TemplateProduct] = []

    private lazy var templateTitle: UILabel = UILabel()
    private lazy var underlineView: UIView = UIView()
    private lazy var productsVStack: UIStackView = UIStackView()
    private lazy var categoryImage: UIImageView = UIImageView()
    private lazy var separateView: UIView = UIView()
    private lazy var breadCountLabel: UILabel = UILabel()
    private lazy var breadCount: UILabel = UILabel()
    private lazy var insulinLabel: UILabel = UILabel()
    private lazy var insulinCount: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(
        templateTitle: String,
        templateCategory: TemplateCategories,
        products: [TemplateProduct],
        stats: (breadCount: String, insulinCount: String)) {
            self.templateTitle.text = templateTitle
            self.products = products
            self.breadCount.text = stats.breadCount
            self.insulinCount.text = stats.insulinCount
            categoryImage.image = templateCategory.getImageByType()
            clearProductVStack()
            fillProductVStack()
    }

    private func setUp() {
        setUpTemplateTitle()
        setUpUnderlineView()
        setUpProductsVStack()
        setUpCategoryImage()
        setUpSeparateView()
        setUpBreadCountLabel()
        setUpBreadCount()
        setUpInsulinLabel()
        setUpInsulinCount()
    }

    private func clearProductVStack() {
        for arrangedSubview in productsVStack.arrangedSubviews {
            arrangedSubview.removeFromSuperview()
        }
    }

    private func setUpTemplateTitle() {
        addSubview(templateTitle)
        templateTitle.textAlignment = .center
        templateTitle.font = UIFont.systemFont(ofSize: 16)
        templateTitle.minimumScaleFactor = 0.5
        templateTitle.adjustsFontSizeToFitWidth = true
        templateTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpUnderlineView() {
        addSubview(underlineView)
        underlineView.backgroundColor = .black
        underlineView.snp.makeConstraints { make in
            make.leading.equalTo(templateTitle.snp.leading)
            make.trailing.equalTo(templateTitle.snp.trailing)
            make.height.equalTo(1)
            make.top.equalTo(templateTitle.snp.bottom).offset(2)
        }
    }

    private func setUpProductsVStack() {
        addSubview(productsVStack)
        productsVStack.axis = .vertical
        productsVStack.distribution = .equalSpacing
        productsVStack.alignment = .leading

        productsVStack.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(64)
            make.height.equalTo(52)
        }
    }

    private func setUpCategoryImage() {
        addSubview(categoryImage)
        categoryImage.image = .cereal
        categoryImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(productsVStack.snp.trailing).offset(10)
            make.top.equalTo(underlineView.snp.bottom).offset(8)
            make.height.equalTo(58)
        }
    }

    private func fillProductVStack() {
        for product in products {
            if productsVStack.arrangedSubviews.count == 3 {
                break
            }
            let hStack: UIStackView = UIStackView()
            productsVStack.addArrangedSubview(hStack)
            hStack.axis = .horizontal
            hStack.spacing = 5
            hStack.alignment = .leading
            let circle: UIImageView = UIImageView()
            circle.image = .blackSliderThumbIcon.resizeImage(newSize: CGSize(width: 10, height: 10))
            circle.contentMode = .center
            let productLabel: UILabel = UILabel()
            productLabel.text = product.name
            productLabel.font = UIFont.systemFont(ofSize: 12)
            productLabel.minimumScaleFactor = 0.5
            productLabel.adjustsFontSizeToFitWidth = true
            hStack.addArrangedSubview(circle)
            hStack.addArrangedSubview(productLabel)
            circle.snp.makeConstraints { make in
                make.width.height.equalTo(14)
                make.centerY.equalTo(productLabel.snp.centerY)
            }
            hStack.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
        }
    }

    private func setUpSeparateView() {
        addSubview(separateView)
        separateView.backgroundColor = .black
        separateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(productsVStack.snp.bottom).offset(15)
        }
    }

    private func setUpBreadCountLabel() {
        addSubview(breadCountLabel)
        breadCountLabel.text = "ХЕ"
        breadCountLabel.font = UIFont.systemFont(ofSize: 12)
        breadCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(separateView.snp.bottom).offset(4)
        }
    }

    private func setUpBreadCount() {
        addSubview(breadCount)
        breadCount.font = UIFont.systemFont(ofSize: 12)
        breadCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(separateView.snp.bottom).offset(4)
        }
    }

    private func setUpInsulinLabel() {
        addSubview(insulinLabel)
        insulinLabel.text = "Инсулин"
        insulinLabel.font = UIFont.systemFont(ofSize: 12)
        insulinLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(breadCountLabel.snp.bottom).offset(2)
        }
    }

    private func setUpInsulinCount() {
        addSubview(insulinCount)
        insulinCount.font = UIFont.systemFont(ofSize: 12)
        insulinCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(breadCount.snp.bottom).offset(2)
        }
    }
}
