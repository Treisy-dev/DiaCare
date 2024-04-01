//
//  ProfileViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let contentView: ProfileView

    private let viewModel: ProfileViewModelProtocol

    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        contentView = ProfileView(
            frame: CGRect(),
            userNameData: viewModel.userInfoData,
            selectedLanguage: viewModel.getSelectedLanguage(), userDefaultsDM: viewModel.userDefaultsDataManager)
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
        contentView.settingsSubView.customTextField.languagePickerView.delegate = self
        contentView.settingsSubView.customTextField.languagePickerView.dataSource = viewModel
    }
}

extension ProfileViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contentView.settingsSubView.customTextField.text = viewModel.languageDataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.languageDataSource[row]
    }
}
