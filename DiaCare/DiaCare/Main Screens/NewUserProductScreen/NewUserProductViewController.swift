//
//  NewUserProductViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 18.04.2024.
//

import UIKit
import Combine

final class NewUserProductViewController: UIViewController {

    var onFinish: (() -> Void)?
    var onFinishWithProduct: ((_ userProduct: UserProductModel) -> Void)?

    private let contentView: NewUserProductView = .init()
    private let viewModel: NewUserProductViewModelProtocol

    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: NewUserProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        contentView.categoryPickerView.delegate = self
        contentView.categoryPickerView.dataSource = viewModel

        contentView.closeAction = { [weak self] in
            self?.onFinish?()
        }

        contentView.addAction = { [weak self] in
            self?.getProductValues()
            self?.viewModel.saveProduct()

            let alert = UIAlertController(
                title: "Новый продукт добавлен!",
                message: "Вы добавили продукт \(self?.contentView.productNameTextField.text ?? "")", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .default) { _ in
                self?.onFinish?()
            }
            alert.addAction(yesAction)
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func getProductValues() {
        contentView.categoryTextField
            .publisher(for: \.text)
            .assign(to: \.value, on: viewModel.productCategory)
            .store(in: &subscriptions)

        contentView.productNameTextField
            .publisher(for: \.text)
            .assign(to: \.value, on: viewModel.productName)
            .store(in: &subscriptions)

        contentView.proteinInputView.countTextField
            .publisher(for: \.text)
            .assign(to: \.value, on: viewModel.proteinCount)
            .store(in: &subscriptions)

        contentView.fatInputView.countTextField
            .publisher(for: \.text)
            .assign(to: \.value, on: viewModel.fatCount)
            .store(in: &subscriptions)

        contentView.carbsInputView.countTextField
            .publisher(for: \.text)
            .assign(to: \.value, on: viewModel.carbsCount)
            .store(in: &subscriptions)
    }
}

extension NewUserProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contentView.categoryTextField.text = viewModel.dataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.dataSource[row]
    }
}
