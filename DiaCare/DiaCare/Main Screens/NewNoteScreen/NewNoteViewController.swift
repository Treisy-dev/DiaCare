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
        contentView.injectionSubView.shortInsulinTextField.delegate = self
        contentView.injectionSubView.longInsulinTextField.delegate = self
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
        contentView.panGestureRecognizer?.delegate = self

        contentView.saveTapped = { [weak self] in
            self?.viewModel.saveNewNote(
                breadCount: self?.contentView.injectionSubView.breadTextField.text ?? "0.0",
                sugar: self?.contentView.sugarSubView.sugarCountLabel.text ?? "5.5",
                shortInsulin: self?.contentView.injectionSubView.shortInsulinTextField.text ?? "0.0",
                longInsulin: self?.contentView.injectionSubView.longInsulinTextField.text ?? "0.0"
            )

            self?.resetChanges()
            self?.updateContentViewLayout()
            self?.contentView.scrollToUpside()

            let alert = UIAlertController(title: "Запись добавлена!", message: "Вы добавили запись", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }

        contentView.foodSubView.addProductTapped = { [weak self] in
            self?.onFinish?()
        }

        contentView.resetTapped = { [weak self] in
            self?.resetChanges()
            self?.updateContentViewLayout()
            self?.contentView.scrollToUpside()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentViewLayout()
        changeInjectionStats()
        contentView.scrollToUpside()
    }

    private func resetChanges() {
        NotificationCenter.default.post(name: Notification.Name("resetNoteChangesNotification"), object: nil)
        contentView.injectionSubView.breadTextField.text = "0"
        contentView.injectionSubView.shortInsulinTextField.text = "0"
        contentView.injectionSubView.longInsulinTextField.text = "0"
        contentView.injectionSubView.breadSlider.value = 0
        contentView.injectionSubView.shortInsulinSlider.value = 0
        contentView.injectionSubView.longInsulinSlider.value = 0
        contentView.sugarSubView.sugarCountLabel.text = viewModel.getAverageSugar()
    }

    private func updateContentViewLayout() {
        contentView.foodSubView.snp.updateConstraints { make in
            make.height.equalTo(140 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.newNoteContentView.snp.updateConstraints { make in
            make.height.equalTo(800 + 70 * CGFloat(Float(viewModel.userProducts.count)))
        }
        contentView.scrollAddition = 70 * CGFloat(Float(viewModel.userProducts.count))
        contentView.layoutIfNeeded()
        contentView.foodSubView.foodtableView.reloadData()
    }

    private func changeInjectionStats() {
        guard let breadCountFloat = Float(viewModel.getBreadCount()),
            let insulinCountFloat = Float(viewModel.getInsulinCount()) else { return }
        contentView.injectionSubView.breadTextField.text = viewModel.getBreadCount()
        contentView.injectionSubView.breadSlider.value = breadCountFloat
        contentView.injectionSubView.shortInsulinTextField.text = viewModel.getInsulinCount()
        contentView.injectionSubView.shortInsulinSlider.value = insulinCountFloat
    }
}

extension NewNoteViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(textField)
    }
}

extension NewNoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        updateContentViewLayout()
    }
}

extension NewNoteViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: contentView.foodSubView)
        let trackedFrame = CGRect(
            x: contentView.foodSubView.foodtableView.frame.minX + 30,
            y: contentView.foodSubView.foodtableView.frame.minY,
            width: contentView.foodSubView.foodtableView.frame.width - 60,
            height: contentView.foodSubView.foodtableView.frame.height
        )
        if trackedFrame.contains(touchLocation) {
            return false
        }
        return true
    }
}
