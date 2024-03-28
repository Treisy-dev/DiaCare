//
//  ProductViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 27.03.2024.
//

import UIKit

final class ProductViewController: UIViewController {

    private let contentView: ProductView = .init()

    private let viewModel: ProductViewModel

    init(viewModel: ProductViewModel) {
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
//        contentView.productTableView.dataSource = viewModel
        contentView.productTableView.delegate = self
        viewModel.translateWord(word: "Apple") { [weak self] result in
            self?.viewModel.getDefaultSizeProduct(product: result) { product in
                for item in product.items {
                    print(item)
                }
            }
        }
    }
}

extension ProductViewController: UITableViewDelegate {

}
