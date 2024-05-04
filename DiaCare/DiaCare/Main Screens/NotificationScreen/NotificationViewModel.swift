//
//  NotificationViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

protocol NotificationViewModelProtocol: UITableViewDataSource {
    var currentDataSource: [PushNotification] { get }
    var finishedDataSource: [PushNotification] { get }
    func addNewNotify(title: String, message: String, date: Date)
    func updateDataSource()
}

final class NotificationViewModel: NSObject, NotificationViewModelProtocol, UITableViewDataSource {
    var currentDataSource: [PushNotification] = []
    var finishedDataSource: [PushNotification] = []
    var coreDataManager: CoreDataManagerProtocol

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
    }

    func updateDataSource() {
        let notifications = coreDataManager.obtainUserNotifications()
        currentDataSource = notifications.filter { $0.date >= Date()}
        finishedDataSource = notifications.filter { $0.date < Date()}
        currentDataSource.sort { $0.date < $1.date}
        finishedDataSource.sort { $0.date > $1.date}
    }

    func addNewNotify(title: String, message: String, date: Date) {
        coreDataManager.addNewNotification(message: message, title: title, date: date)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Действующиие напомнинания"
        } else {
            return "Старые напоминания"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return currentDataSource.count
        } else {
            return finishedDataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = NotificationTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none

            cell.config(
                isColored: true,
                title: currentDataSource[indexPath.row].title,
                date: getDate(date: currentDataSource[indexPath.row].date),
                time: getTime(date: currentDataSource[indexPath.row].date))
            return cell
        } else {
            let cell = NotificationTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.config(
                isColored: false,
                title: finishedDataSource[indexPath.row].title,
                date: getDate(date: finishedDataSource[indexPath.row].date),
                time: getTime(date: finishedDataSource[indexPath.row].date))
            return cell
        }
    }

    private func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }

    private func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
