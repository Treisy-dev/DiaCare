//
//  ProductView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//
import SnapKit
import UIKit

final class ProductView: UIView {

    private lazy var productSearchBar: UISearchBar = UISearchBar()
    private lazy var typesSegmentControl: UISegmentedControl = UISegmentedControl(items: ["Все", "Шаблоны", "Мои"])
    private lazy var addProductButton: CustomAddFoodButton = CustomAddFoodButton(frame: frame, title: "Добавить свой продукт")
    lazy var productTableView: UITableView = UITableView()
    private lazy var addButton: UIButton = UIButtonFabric.shared.makeAddButton()
    private lazy var closeButton: UIButton = UIButtonFabric.shared.makeCloseButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpProductSearchBar()
        setUpTypesSegmentControl()
        setUpAddProductButton()
        setUpProductTableView()
        setUpAddButton()
        setUpCloseButton()
    }

    private func setUpProductSearchBar() {
        addSubview(productSearchBar)
        productSearchBar.placeholder = "Поиск"
        productSearchBar.searchBarStyle = .minimal
        productSearchBar.layer.cornerRadius = 10

        let searchIcon = UIImage(systemName: "magnifyingglass")
        productSearchBar.setImage(searchIcon, for: .search, state: .normal)

        productSearchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().inset(22)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(40)
        }
    }

    private func setUpTypesSegmentControl() {
        addSubview(typesSegmentControl)
        typesSegmentControl.selectedSegmentIndex = 0
        typesSegmentControl.selectedSegmentTintColor = .mainApp

        let font = UIFont.systemFont(ofSize: 16)
        typesSegmentControl.selectedSegmentTintColor = .mainApp
        typesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.lightGray, .font: font], for: .normal)
        typesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: font], for: .selected)

        typesSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(productSearchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpAddProductButton() {
        addSubview(addProductButton)
        addProductButton.snp.makeConstraints { make in
            make.top.equalTo(typesSegmentControl.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
    }

    private func setUpProductTableView() {
        addSubview(productTableView)
        productTableView.snp.makeConstraints { make in
            make.top.equalTo(addProductButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(150)
        }
    }

    private func setUpAddButton() {
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(productTableView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(155)
            make.height.equalTo(40)
        }
    }

    private func setUpCloseButton() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(productTableView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(155)
            make.height.equalTo(40)
        }
    }
}
