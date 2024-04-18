//
//  NewNoteViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

final class NewNoteViewController: UIViewController {

    private let contentView: NewNoteView

    var viewModel: NewNoteViewModelProtocol

    var onFinish: (() -> Void)?

    init(viewModel: NewNoteViewModelProtocol) {
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

        contentView.foodSubView.foodtableView.delegate = self
        contentView.foodSubView.foodtableView.dataSource = viewModel

        contentView.foodSubView.addProductTapped = { [weak self] in
            self?.onFinish?()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.foodSubView.snp.updateConstraints { make in
            make.height.equalTo(140 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.newNoteContentView.snp.updateConstraints { make in
            make.height.equalTo(700 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.scrollAddition = 70 * CGFloat(Float(viewModel.userProducts.count))
        contentView.layoutIfNeeded()
        contentView.foodSubView.foodtableView.reloadData()
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

extension NewNoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
