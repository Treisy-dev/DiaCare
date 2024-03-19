//
//  SugarViewViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import UIKit

final class SugarConfigViewController: UIViewController {

    private let contentView: SugarConfigView = .init()

    private let viewModel: SugarConfigViewModel

    init(viewModel: SugarConfigViewModel) {
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
        contentView.pickerView.delegate = self
        contentView.pickerView.dataSource = viewModel
        contentView.delegate = self
    }
}

extension SugarConfigViewController: SugarConfigViewDelegate {
    func didPressNext(lowSugar: String?, targetSugar: String?, hightSugar: String?) {
        viewModel.saveUserInfo(lowSugar: lowSugar, targetSugar: targetSugar, hightSugar: hightSugar)
        self.navigationController?.pushViewController(
            WelcomeScreensControllerFabric.shared.makeFoodConfigVC(),
            animated: true)
    }

    func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SugarConfigViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let activeTextField = UIResponder.currentFirstResponder as? UITextField {
            if activeTextField == contentView.lowSugarField {
                contentView.lowSugarField.text = viewModel.dataSource[row]
            } else if activeTextField == contentView.targetSugarField {
                contentView.targetSugarField.text = viewModel.dataSource[row]
            } else if activeTextField == contentView.hightSugarField {
                contentView.hightSugarField.text = viewModel.dataSource[row]
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.dataSource[row]
    }
}

extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder?

    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    @objc private func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
}
