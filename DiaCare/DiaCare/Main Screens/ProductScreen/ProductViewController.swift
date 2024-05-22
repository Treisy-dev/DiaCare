//
//  ProductViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit
import Combine

final class ProductViewController: UIViewController {

    let viewModel: ProductViewModelProtocol

    var productTapped: ((_ productName: String, _ productProps: (fat: String, protein: String, carbs: String)) -> Void)?
    var onFinishWithProducts: (([UserProductModel]) -> Void)?
    var onFinish: (() -> Void)?
    var addUserProductTapped: (() -> Void)?

    private let contentView: ProductView = .init()

    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: ProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        contentView.productTableView.dataSource = viewModel
        contentView.productTableView.delegate = self
        contentView.productSearchBar.delegate = self
        contentView.productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)

        contentView.addAction = { [weak self] in
            guard let usersProducts = self?.viewModel.usersProduct else { return }
            self?.onFinishWithProducts?(usersProducts)
        }

        contentView.closeAction = { [weak self] in
            guard let isEmpty = self?.viewModel.usersProduct.isEmpty else { return }
            if isEmpty {
                self?.onFinish?()
            } else {
                let alertController = UIAlertController(
                    title: "Удалить добавленные продукты?",
                    message: "У вас есть добавленные продукты, вы действительно хотите отменить добавление?",
                    preferredStyle: .alert
                )
                let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
                    self?.onFinish?()
                }
                let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in
                    alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }

        contentView.addUserProfuctAction = { [weak self] in
            self?.addUserProductTapped?()
        }

        setUpBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.typesSegmentControl.selectedSegmentIndex = viewModel.selectedIndex.value
        if viewModel.userSavedProducts.count != 0 {
            contentView.addButton.setTitle("Добавить(\(viewModel.userSavedProducts.count))", for: .normal)
        }
    }

    private func setUpBindings() {
        setUpSearchBinding()
        setUpCategoryBinding()
    }

    private func setUpCategoryBinding() {

        contentView.typesSegmentControl
            .publisher(for: \.selectedSegmentIndex)
            .sink { [weak self] selectedIndex in
                self?.checkHintVisibility(selectedIndex: selectedIndex)
            }
            .store(in: &subscriptions)

        contentView.typesSegmentControl
            .publisher(for: \.selectedSegmentIndex)
            .assign(to: \.value, on: viewModel.selectedIndex)
            .store(in: &subscriptions)
    }

    private func checkHintVisibility(selectedIndex: Int) {
        if selectedIndex == 0 {
            if viewModel.productItem.count == 0 {
                contentView.hintLabel.isHidden = false
                contentView.hintLabel.text = "Введите наименование продукта в строку поиска"
            } else {
                contentView.hintLabel.isHidden = true
            }
            contentView.productTableView.reloadData()
        } else if selectedIndex == 1 {
            NotificationCenter.default.post(name: Notification.Name("updateUserTemplatesDataNotification"), object: nil)
            if viewModel.userTemplates.count == 0 {
                contentView.hintLabel.isHidden = false
                contentView.hintLabel.text = "У вас пока нет своих добавленных шаблонов"
            } else {
                contentView.hintLabel.isHidden = true
            }
            contentView.productTableView.reloadData()
        } else {
            NotificationCenter.default.post(name: Notification.Name("updateUserSavedProductsDataNotification"), object: nil)
            if viewModel.userSavedProducts.count == 0 {
                contentView.hintLabel.isHidden = false
                contentView.hintLabel.text = "У вас пока нет своих добавленных продуктов"
            } else {
                contentView.hintLabel.isHidden = true
            }
            contentView.productTableView.reloadData()
        }
    }

    private func setUpSearchBinding() {
        contentView.productSearchBar.searchTextField
            .publisher(for: \.text)
            .removeDuplicates()
            .sink { [weak self] queryText in
                guard let queryText,
                    !queryText.isEmpty else { return }
                self?.contentView.hintLabel.isHidden = true
                self?.contentView.loadAnimationView.startAnimating()
                self?.viewModel.searchProducts(for: queryText) {
                    self?.contentView.loadAnimationView.stopAnimating()
                    self?.contentView.productTableView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell else { return }
        guard let productName = cell.productLabel.text else { return }
        if viewModel.selectedIndex.value == 0 {
            productTapped?(
                productName,
                (
                    fat: String(viewModel.productItem[indexPath.row].fat_total_g),
                    protein: String(viewModel.productItem[indexPath.row].protein_g),
                    carbs: String(viewModel.productItem[indexPath.row].carbohydrates_total_g)
                )
            )
        } else if viewModel.selectedIndex.value == 1 {
            let selectedTemplate = viewModel.userTemplates[indexPath.row]
            let alertController = UIAlertController(
                title: "Добавить шаблон?",
                message: "Добавить шаблон \(productName) в прием пищи?",
                preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
                self?.viewModel.addUserProduct(product: UserProductModel(
                    name: productName,
                    protein: self?.viewModel.getProteintForTemplate(for: selectedTemplate) ?? "0",
                    fat: self?.viewModel.getFatForTemplate(for: selectedTemplate) ?? "0",
                    carbs: self?.viewModel.getCarbsForTemplate(for: selectedTemplate) ?? "0",
                    breadCount: self?.viewModel.userTemplates[indexPath.row].breadCount ?? "0",
                    isTemplate: true
                )
                )
            }
            let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            present(alertController, animated: true, completion: nil)
        } else {
            productTapped?(
                productName,
                (
                    fat: String(viewModel.userSavedProducts[indexPath.row].fat),
                    protein: String(viewModel.userSavedProducts[indexPath.row].protein),
                    carbs: String(viewModel.userSavedProducts[indexPath.row].carbohydrates)
                )
            )
        }
    }
}

extension ProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBar.selectAll(searchBar)
        }
    }
}
