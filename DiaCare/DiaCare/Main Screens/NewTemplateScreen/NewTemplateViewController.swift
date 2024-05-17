//
//  NewTemplateViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//

import UIKit

final class NewTemplateViewController: UIViewController {

    var viewModel: NewTemplateViewModelProtocol
    var onFinish: (() -> Void)?
    var addProductTapped: (() -> Void)?

    private let contentView: NewTemplateView = .init()

    init(viewModel: NewTemplateViewModelProtocol) {
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
        contentView.foodSubView.foodTableView.delegate = self
        contentView.foodSubView.foodTableView.dataSource = viewModel
        contentView.foodSubView.foodTableView.register(
            UserProductTableViewCell.self,
            forCellReuseIdentifier: UserProductTableViewCell.reuseIdentifier
        )
        contentView.categoryPickerView.dataSource = viewModel
        contentView.categoryPickerView.delegate = self

        contentView.resetTapped = { [weak self] in
            if self?.viewModel.userProducts.count != 0 {
                let alert = UIAlertController(
                    title: "Удалить шаблон?",
                    message: "В шаблоне есть добавленные продукты. Вы действительно хотите отменить изменения и вернуться?",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self?.onFinish?()
                }
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
            } else {
                self?.onFinish?()
            }
        }
        contentView.saveTapped = { [weak self] in
            self?.viewModel.saveNewTemplate(
                breadCount: self?.contentView.injectionSubView.breadCountTextField.text ?? "",
                shortInsulin: self?.contentView.injectionSubView.insulinTextField.text ?? "",
                name: self?.contentView.nameTextField.text ?? "",
                category: self?.contentView.categoryTextField.text ?? ""
            )

            let alert = UIAlertController(title: "Шаблон добавлен!", message: "Вы добавили шаблон", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self?.onFinish?()
            }
            alert.addAction(okAction)
            self?.present(alert, animated: true, completion: nil)
        }

        contentView.foodSubView.addProductTapped = { [weak self] in
            self?.addProductTapped?()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeInjectionStats()
        changeSummaryStats()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentViewLayout()
    }

    private func updateContentViewLayout() {
        contentView.foodSubView.snp.updateConstraints { make in
            make.height.equalTo(70 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.newTemplateContentView.snp.updateConstraints { make in
            make.height.equalTo(650 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.scrollAddition = 70 * CGFloat(Float(viewModel.userProducts.count))
        contentView.layoutIfNeeded()
        contentView.foodSubView.foodTableView.reloadData()
    }

    private func changeInjectionStats() {
        contentView.injectionSubView.breadCountTextField.text = viewModel.getBreadCount()
        contentView.injectionSubView.insulinTextField.text = viewModel.getInsulinCount()
    }

    private func changeSummaryStats() {
        guard let proteinView = contentView.statsSubView.proteinVStack.arrangedSubviews[1] as? CustomCircledView,
            let fatView = contentView.statsSubView.fatVStack.arrangedSubviews[1] as? CustomCircledView,
            let carbsView = contentView.statsSubView.carbsVStack.arrangedSubviews[1] as? CustomCircledView,
            let breadCountView = contentView.statsSubView.breadCountVStack.arrangedSubviews[1] as? CustomCircledView,
            let insulinView = contentView.statsSubView.insulinVStack.arrangedSubviews[1] as? CustomCircledView else { return }
        fatView.countLabel.text = viewModel.getFatCount()
        proteinView.countLabel.text = viewModel.getProteinCount()
        carbsView.countLabel.text = viewModel.getCarbsCount()
        breadCountView.countLabel.text = viewModel.getBreadCount()
        insulinView.countLabel.text = viewModel.getInsulinCount()
    }
}

extension NewTemplateViewController: UITableViewDelegate, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        contentView.categoryTextField.text = viewModel.pickerViewDataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerViewDataSource[row]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
