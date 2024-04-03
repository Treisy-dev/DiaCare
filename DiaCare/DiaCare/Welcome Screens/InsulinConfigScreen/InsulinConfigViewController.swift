//
//  InsulinConfigViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import UIKit

final class InsulinConfigViewController: UIViewController {

    private let contentView: InsulinConfigView = .init()

    private let viewModel: InsulinConfigViewModelProtocol

    var onFinish: (() -> Void)?
    var onBack: (() -> Void)?

    init(viewModel: InsulinConfigViewModelProtocol) {
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
        contentView.delegate = self
        contentView.shortPickerView.delegate = self
        contentView.shortPickerView.dataSource = viewModel
        contentView.longPickerView.delegate = self
        contentView.longPickerView.dataSource = viewModel
    }
}

extension InsulinConfigViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == contentView.shortPickerView {
            contentView.shortInsulinField.text = viewModel.shortDataSource[row]
        } else {
            contentView.longInsulinField.text = viewModel.longDataSource[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == contentView.shortPickerView {
            viewModel.shortDataSource[row]
        } else {
            viewModel.longDataSource[row]
        }
    }
}

extension InsulinConfigViewController: InsulinConfigViewDelegate {
    func didPressSave(shortInsulin: String?, longInsulin: String?) {
        viewModel.saveUserInfo(shortInsulin: shortInsulin, longInsulin: longInsulin)
        viewModel.coreDataManager.setUpDefaultProductTypes()
        onFinish?()
    }

    func didPressBack() {
        onBack?()
    }
}
