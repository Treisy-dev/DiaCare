//
//  TemplateViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

class TemplateViewController: UIViewController {

    private let contentView: TemplateView

    private let viewModel: TemplateViewModelProtocol

    var onFinish: (() -> Void)?

    init(viewModel: TemplateViewModelProtocol) {
        self.viewModel = viewModel
        contentView = TemplateView(frame: CGRect())
        super.init(nibName: nil, bundle: nil)
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
}
