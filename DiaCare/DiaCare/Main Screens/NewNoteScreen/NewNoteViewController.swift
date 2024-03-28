//
//  NewNoteViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

final class NewNoteViewController: UIViewController {

    private let contentView: NewNoteView

    private let viewModel: NewNoteViewModel

    init(viewModel: NewNoteViewModel) {
        self.viewModel = viewModel
        contentView = NewNoteView(frame: CGRect(), averageSugar: viewModel.averageSugar)
        super.init(nibName: nil, bundle: nil)
        contentView.injectionSubView.breadTextField.delegate = self
        contentView.injectionSubView.insulinTextField.delegate = self
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.foodSubView.addProductTapped = { [weak self] in
            let viewModel = ProductViewModel(translationService: TranslationNetworkService(), productService: ProductNetworkService())
            self?.navigationController?.pushViewController(ProductViewController(viewModel: viewModel), animated: true)
        }
    }
}

extension NewNoteViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}
