//
//  FoodConfigViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import UIKit

final class FoodConfigViewController: UIViewController {

    private let contentView: FoodConfigView = .init()

    private let viewModel: FoodConfigViewModel

    init(viewModel: FoodConfigViewModel) {
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
        contentView.pickerView.delegate = self
        contentView.pickerView.dataSource = viewModel
    }
}

extension FoodConfigViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contentView.insulinTextField.text = viewModel.dataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.dataSource[row]
    }
}

extension FoodConfigViewController: FoodConfigViewDelegate {
    func didPressNext(breadCount: String?, insulinCount: String?) {
        viewModel.saveUserInfo(breadCount: breadCount, insulinCount: insulinCount)
        self.navigationController?.pushViewController(
            WelcomeScreensControllerFabric.shared.makeInsulinConfigVC(),
            animated: true)
    }

    func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
