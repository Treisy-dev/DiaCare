//
//  NotificationConfigViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 04.05.2024.
//

import UIKit

final class NotificationConfigViewController: UIViewController {

    private let contentView: NotificationConfigView = .init()
    private let viewModel: NotificationConfigViewModelProtocol

    init(viewModel: NotificationConfigViewModelProtocol) {
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
        self.navigationController?.isNavigationBarHidden = true
        contentView.backButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        contentView.addButtonTapped = { [weak self] in
            let alert = UIAlertController(
                title: "Напоминание добавлено!",
                message: "Вы добавили напоминание \(self?.contentView.titleTextField.text ?? "")",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
                guard let previousVC = self?.navigationController?.topViewController as? NotificationViewController else { return }
                self?.sendNotification(
                    date: self?.contentView.datePicker.date ?? Date(),
                    title: self?.contentView.titleTextField.text ?? "",
                    message: self?.contentView.messageTextField.text ?? ""
                )
                previousVC.addNewNotify(
                    title: self?.contentView.titleTextField.text ?? "",
                    message: self?.contentView.messageTextField.text ?? "",
                    date: self?.contentView.datePicker.date ?? Date()
                )
            }
            alert.addAction(okAction)
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func sendNotification(date: Date, title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = message

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: date.description + title, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
