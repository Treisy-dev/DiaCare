//
//  ProductView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//
import SnapKit
import UIKit

final class ProductView: UIView {

    lazy var productSearchBar: UISearchBar = UISearchBar()
    lazy var typesSegmentControl: UISegmentedControl = UISegmentedControl(items: ["Все", "Шаблоны", "Мои"])
    private lazy var addProductButton: CustomAddFoodButton = CustomAddFoodButton(frame: frame, title: "Добавить свой продукт")
    lazy var productTableView: UITableView = UITableView()
    lazy var hintLabel: UILabel = UILabel()
    private lazy var addButton: UIButton = UIButtonFabric.shared.makeAddButton()
    private lazy var closeButton: UIButton = UIButtonFabric.shared.makeCloseButton()
    lazy var loadAnimationView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    var addUserProfuctAction: (() -> Void)?
    var closeAction: (() -> Void)?
    var addAction: (() -> Void)?

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
        setUpHintLabel()
        setUpLoadAnimationView()
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
        let addProductButtonAction: UIAction = UIAction { [weak self] _ in
            self?.addUserProfuctAction?()
        }

        addProductButton.addAction(addProductButtonAction, for: .touchUpInside)
        addProductButton.snp.makeConstraints { make in
            make.top.equalTo(typesSegmentControl.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
    }

    private func setUpProductTableView() {
        addSubview(productTableView)
        productTableView.separatorColor = .clear
        productTableView.snp.makeConstraints { make in
            make.top.equalTo(addProductButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(150)
        }
    }

    private func setUpHintLabel() {
        addSubview(hintLabel)
        hintLabel.text = "Введите наименование продукта в строку поиска"
        hintLabel.font = UIFont.systemFont(ofSize: 20)
        hintLabel.numberOfLines = 2
        hintLabel.textAlignment = .center
        hintLabel.textColor = .systemGray.withAlphaComponent(0.5)

        hintLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
        }
    }

    private func setUpLoadAnimationView() {
        addSubview(loadAnimationView)
        loadAnimationView.color = .mainApp
        loadAnimationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        loadAnimationView.hidesWhenStopped = true

        loadAnimationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setUpAddButton() {
        addSubview(addButton)
        let addAction: UIAction = UIAction { [weak self] _ in
            self?.addButton.addAlphaAnimation()
            self?.addAction?()
        }
        addButton.addAction(addAction, for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(productTableView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(155)
            make.height.equalTo(40)
        }
    }

    private func setUpCloseButton() {
        addSubview(closeButton)
        let closeAction: UIAction = UIAction { [weak self] _ in
            self?.closeButton.addAlphaAnimation()
            self?.closeAction?()
        }
        closeButton.addAction(closeAction, for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(productTableView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(155)
            make.height.equalTo(40)
        }
    }
}
