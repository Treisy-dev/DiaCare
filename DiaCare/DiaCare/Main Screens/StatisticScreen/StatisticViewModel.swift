//
//  StatisticViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit
import DGCharts
import Combine

protocol StatisticViewModelProtocol: UITableViewDataSource {
    var dataSource: [NotesHistory] { get }

    func getSugarHistoryDay(startDate: Date, endDate: Date) -> [ChartDataEntry]
    func getSugarHistoryWeek(startDate: Date, endDate: Date) -> [ChartDataEntry]
    func getMinimalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getAverageSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getMaximalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getBreadCountBy(startDate: Date, endDate: Date) -> Double
    func getShortInsulinBy(startDate: Date, endDate: Date) -> Double
    func getLongInsulinBy(startDate: Date, endDate: Date) -> Double
}

final class StatisticViewModel: NSObject, StatisticViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol
    var userDefaultsDataManager: UserDefaultsDataManagerProtocol
    var dataSource: [NotesHistory] = []

    init(coreDM: CoreDataManagerProtocol, userDefaultsDM: UserDefaultsDataManagerProtocol) {
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationReceived),
            name: Notification.Name("updateStatisticDataNotification"),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("updateStatisticDataNotification"), object: nil)
    }

    @objc func notificationReceived(_ notification: Notification) {
        guard let datePair = notification.object as? (Date, Date) else { return }
        updateTableDataSource(startDate: datePair.0, endDate: datePair.1)
    }

    func getSugarHistoryDay(startDate: Date, endDate: Date) -> [ChartDataEntry] {
        let sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)

        var chartDataEntryArray: [ChartDataEntry] = []
        for (sugarValue, date) in sugarData {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour], from: date)
            let hour = components.hour ?? 0

            let chartDataEntry = ChartDataEntry(x: Double(hour), y: Double(sugarValue))
            chartDataEntryArray.append(chartDataEntry)
        }

        return chartDataEntryArray
    }

    func getSugarHistoryWeek(startDate: Date, endDate: Date) -> [ChartDataEntry] {
        let sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)

        var sugarValuesPerDay: [Int: [Double]] = [:]

        for (sugarValue, date) in sugarData {
            let day = Calendar.current.dateComponents([.day], from: date).day ?? 0
            sugarValuesPerDay[day, default: []].append(sugarValue)
        }

        var chartDataEntryArray: [ChartDataEntry] = []

        for (day, sugarValues) in sugarValuesPerDay {
            let averageSugarValue = sugarValues.reduce(0, { $0 + $1 }) / Double(sugarValues.count)
            let chartDataEntry = ChartDataEntry(x: Double(day), y: averageSugarValue)
            chartDataEntryArray.append(chartDataEntry)
        }

        return chartDataEntryArray
    }

    func getMinimalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState) {
        var sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)
        sugarData.sort { $0.0 < $1.0 }
        guard let minimalSugar = sugarData.first?.0 else { return (0, .normal) }
        guard let target = Double(userDefaultsDataManager.getLowTarget()) else { return (0, .normal) }

        return (minimalSugar, getMinimalSugarState(target: target, value: minimalSugar))
    }

    func getAverageSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState) {
        let sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)
        if sugarData.count == 0 {
            return (0, .normal)
        }
        let averageSugarValue = Double(sugarData.reduce(0, { $0 + $1.0 })) / Double(sugarData.count)
        guard let target = Double(userDefaultsDataManager.getAverageTarget()) else { return (0, .normal) }

        return (averageSugarValue, getAverageSugarState(target: target, value: averageSugarValue))
    }

    func getMaximalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState) {
        var sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)
        sugarData.sort { $0.0 < $1.0 }
        guard let maximalSugar = sugarData.last?.0 else { return (0, .normal) }
        guard let target = Double(userDefaultsDataManager.getHighTarget()) else { return (0, .normal) }

        return (maximalSugar, getMaximalSugarState(target: target, value: maximalSugar))
    }

    func getBreadCountBy(startDate: Date, endDate: Date) -> Double {
        return coreDataManager.obtainBreadCountBy(from: startDate, to: endDate)
    }

    func getShortInsulinBy(startDate: Date, endDate: Date) -> Double {
        return coreDataManager.obtainShortInsulinCountBy(from: startDate, to: endDate)
    }

    func getLongInsulinBy(startDate: Date, endDate: Date) -> Double {
        return coreDataManager.obtainLongInsulinCountBy(from: startDate, to: endDate)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryTableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none

        let date = dataSource[indexPath.row].date
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let formattedTime = timeFormatter.string(from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        let formattedDate = dateFormatter.string(from: date)

        cell.config(
            date: (formattedDate, formattedTime),
            bloodCount: String(dataSource[indexPath.row].sugar),
            breadCount: String(dataSource[indexPath.row].breadCount),
            insulinCount: String(dataSource[indexPath.row].shortInsulin),
            longInsulinCount: String(dataSource[indexPath.row].longInsulin)
        )
        return cell
    }

    private func updateTableDataSource(startDate: Date, endDate: Date) {
        dataSource = coreDataManager.obtainHistoryBy(from: startDate, to: endDate)
    }

    private func getMinimalSugarState(target: Double, value: Double) -> SugarState {
        if abs(value - target) <= 0.5 {
            return .good
        } else if value - target >= -0.8 && value - target < 0 {
            return .normal
        } else if value - target < -0.8 {
            return .bad
        } else {
            return .good
        }
    }

    private func getAverageSugarState(target: Double, value: Double) -> SugarState {
        if abs(value - target) <= 2 {
            return .good
        } else if abs(value - target) <= 4 {
            return .normal
        } else if abs(value - target) > 4 {
            return .bad
        } else {
            return .normal
        }
    }

    private func getMaximalSugarState(target: Double, value: Double) -> SugarState {
        if value - target <= 2 {
            return .good
        } else if value - target > 2 && value - target < 3 {
            return .normal
        } else if value - target > 3 {
            return .bad
        } else {
            return .good
        }
    }
}
