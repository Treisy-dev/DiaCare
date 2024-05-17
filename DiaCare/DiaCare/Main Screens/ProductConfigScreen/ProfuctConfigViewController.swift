//
//  ProfuctConfigViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.04.2024.
//

import UIKit

final class ProfuctConfigViewController: UIViewController {

    private let contentView: ProductConfigView

    private let viewModel: ProductConfigViewModelProtocol

    var onFinish: (() -> Void)?
    var onFinishWithProduct: ((_ userProduct: UserProductModel) -> Void)?

    init(
        viewModel: ProductConfigViewModelProtocol,
        productName: String,
        productProps: (String, String, String)
    ) {
        self.viewModel = viewModel
        contentView = ProductConfigView(
            frame: .zero,
            productName: productName,
            productProps: productProps,
            userBreadCount: self.viewModel.getUserBreadCount()
        )
        super.init(nibName: nil, bundle: nil)
        contentView.addAction = { [weak self] userProduct in
            self?.onFinishWithProduct?(userProduct)
        }
        contentView.closeAction = { [weak self] in
            self?.onFinish?()
        }
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {

    }

}
