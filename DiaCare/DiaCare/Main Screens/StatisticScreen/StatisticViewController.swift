//
//  StatisticViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit
import Combine

final class StatisticViewController: UIViewController {

    private var contentView: StatisticView?
    private let viewModel: StatisticViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()
    private var wasOpened: Bool = false

    init(viewModel: StatisticViewModelProtocol) {
        self.viewModel = viewModel
        var startComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        startComponents.hour = 0
        startComponents.minute = 0
        startComponents.second = 0
        let startDate = Calendar.current.date(from: startComponents)
        var endComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        endComponents.hour = 23
        endComponents.minute = 59
        endComponents.second = 59
        let endDate = Calendar.current.date(from: endComponents)
        self.contentView = StatisticView(
            frame: .zero,
            chartData: viewModel.getSugarHistoryDay(
                startDate: startDate ?? Date(),
                endDate: endDate ?? Date()),
            lowSugar: viewModel.getMinimalSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            averageSugar: viewModel.getAverageSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            highSugar: viewModel.getMaximalSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            shortInsulinCount: viewModel.getShortInsulinBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            breadCount: viewModel.getBreadCountBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            longInsulinCount: viewModel.getLongInsulinBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()))
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
        setUpBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        contentView?.layoutSubviews()
        guard let startDate = Calendar.current.date(from: getTodayComponents()),
            let endDate = Calendar.current.date(from: getEndOfDayComponents()) else { return }
        contentView?.timeSegmentControll.selectedSegmentIndex = 0
        if wasOpened {
            contentView?.updateUI(
                chartData: viewModel.getSugarHistoryDay(startDate: startDate, endDate: endDate),
                sugarStats: (
                    lowSugar: viewModel.getMinimalSugarBy(startDate: startDate, endDate: endDate),
                    averageSugar: viewModel.getAverageSugarBy(startDate: startDate, endDate: endDate),
                    highSugar: viewModel.getMaximalSugarBy(startDate: startDate, endDate: endDate)),
                foodStats: (
                    shortInsulin: viewModel.getShortInsulinBy(startDate: startDate, endDate: endDate),
                    breadCount: viewModel.getBreadCountBy(startDate: startDate, endDate: endDate),
                    longInsulin: viewModel.getBreadCountBy(startDate: startDate, endDate: endDate)))
        } else {
            wasOpened.toggle()
        }
    }

    private func setUpBinding() {
        contentView?.timeSegmentControll
            .publisher(for: \.selectedSegmentIndex)
            .sink(receiveValue: { [weak self] index in
                switch index {
                case 0:
                    guard let startComponent = self?.getTodayComponents(), let endComponents = self?.getEndOfDayComponents(),
                        let endDate = Calendar.current.date(from: endComponents),
                        let startDate = Calendar.current.date(from: startComponent),
                        let data = self?.viewModel.getSugarHistoryDay(startDate: startDate, endDate: endDate) else { return }

                    self?.contentView?.chartData = data.sorted {$0.x < $1.x}
                    self?.contentView?.chart.xAxis.labelCount = 12
                    self?.contentView?.chart.xAxis.axisMinimum = 0.0
                    self?.contentView?.chart.xAxis.axisMaximum = 22.0
                case 1:
                    guard let startComponent = self?.getWeekStartComponents(), let endComponents = self?.getEndOfDayComponents(),
                        let endDate = Calendar.current.date(from: endComponents),
                        let startDate = Calendar.current.date(from: startComponent),
                        let data = self?.viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate),
                        let startOfChart = data.first?.x else { return }

                    self?.contentView?.chartData = data.sorted {$0.x < $1.x}
                    self?.contentView?.chart.xAxis.labelCount = 6
                    self?.contentView?.chart.xAxis.axisMinimum = startOfChart
                    self?.contentView?.chart.xAxis.axisMaximum = startOfChart + 6
                case 2:
                    guard let startComponent = self?.getMonthStartComponents(), let endComponents = self?.getMonthEndComponents(),
                        let endDate = Calendar.current.date(from: endComponents),
                        let startDate = Calendar.current.date(from: startComponent),
                        let data = self?.viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate) else { return }

                    self?.contentView?.chartData = data.sorted {$0.x < $1.x}
                    self?.contentView?.chart.xAxis.labelCount = 15
                    self?.contentView?.chart.xAxis.axisMinimum = 0.0
                    self?.contentView?.chart.xAxis.axisMaximum = 30.0
                default:
                    print(1)
                }
            })
            .store(in: &subscriptions)
    }

    private func getTodayComponents() -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 0
        components.minute = 0
        components.second = 0
        return components
    }

    private func getWeekStartComponents() -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.day = (components.day ?? 7) - 6
        components.hour = 0
        components.minute = 0
        components.second = 0
        return components
    }

    private func getMonthStartComponents() -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month], from: Date())
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        return components
    }

    private func getEndOfDayComponents() -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 23
        components.minute = 59
        components.second = 59
        return components
    }

    private func getMonthEndComponents() -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month], from: Date())
        components.day = 30
        components.hour = 23
        components.minute = 59
        components.second = 59
        return components
    }

}
