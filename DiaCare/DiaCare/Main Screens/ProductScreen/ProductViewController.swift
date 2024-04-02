//
//  ProductViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit
import Combine

final class ProductViewController: UIViewController {

    private let contentView: ProductView = .init()

    private let viewModel: ProductViewModelProtocol

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

        setUpBindings()
    }

    private func setUpBindings() {
        setUpSearchBinding()
    }

    private func setUpSearchBinding() {
        contentView.productSearchBar.searchTextField.textPublisher
            .removeDuplicates()
            .sink { [weak self] queryText in
                guard !queryText.isEmpty else { return }
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
}

extension ProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
