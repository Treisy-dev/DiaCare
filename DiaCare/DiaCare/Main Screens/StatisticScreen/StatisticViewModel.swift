//
//  StatisticViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit
import DGCharts
import Combine

protocol StatisticViewModelProtocol {
    func getSugarHistoryDay(startDate: Date, endDate: Date) -> [ChartDataEntry]
    func getSugarHistoryWeek(startDate: Date, endDate: Date) -> [ChartDataEntry]
    func getMinimalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getAverageSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getMaximalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState)
    func getBreadCountBy(startDate: Date, endDate: Date) -> Double
    func getShortInsulinBy(startDate: Date, endDate: Date) -> Double
    func getLongInsulinBy(startDate: Date, endDate: Date) -> Double
}

final class StatisticViewModel: StatisticViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol
    var userDefaultsDataManager: UserDefaultsDataManagerProtocol

    init(coreDM: CoreDataManagerProtocol, userDefaultsDM: UserDefaultsDataManagerProtocol) {
        coreDataManager = coreDM
        userDefaultsDataManager = userDefaultsDM
    }

    func getSugarHistoryDay(startDate: Date, endDate: Date) -> [ChartDataEntry] {
        var sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)

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
        var sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)

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
        sugarData.sort { $0.0 < $1.0}
        guard let minimalSugar = sugarData.first?.0 else { return (0, .normal) }
        guard let target = Double(userDefaultsDataManager.getLowTarget()) else { return (0, .normal) }

        return (minimalSugar, getSugarState(target: target, value: minimalSugar, multiplyer: 1))
    }

    func getAverageSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState) {
        let sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)
        let averageSugarValue = Double(sugarData.reduce(0, { $0 + $1.0 })) / Double(sugarData.count)
        guard let target = Double(userDefaultsDataManager.getAverageTarget()) else { return (0, .normal) }

        return (averageSugarValue, getSugarState(target: target, value: averageSugarValue, multiplyer: 3))
    }

    func getMaximalSugarBy(startDate: Date, endDate: Date) -> (Double, SugarState) {
        var sugarData = coreDataManager.obtainAllSugarWithDateHistory(from: startDate, to: endDate)
        sugarData.sort { $0.0 < $1.0}
        guard let maximalSugar = sugarData.last?.0 else { return (0, .normal) }
        guard let target = Double(userDefaultsDataManager.getHighTarget()) else { return (0, .normal) }

        return (maximalSugar, getSugarState(target: target, value: maximalSugar, multiplyer: 2))
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

    private func getSugarState(target: Double, value: Double, multiplyer: Double) -> SugarState {
        if abs(value - target) <= 0.5 * multiplyer {
            return .good
        } else if abs(value - target) <= 1 * multiplyer {
            return .normal
        } else if abs(value - target) < 1 * multiplyer {
            return .bad
        } else {
            return .normal
        }
    }
}
