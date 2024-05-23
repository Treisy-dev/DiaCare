//
//  StatisticViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit
import Combine
import DGCharts

enum DateDuration {
    case day
    case week
    case month
}

final class StatisticViewController: UIViewController {

    private let viewModel: StatisticViewModelProtocol

    private var contentView: StatisticView?
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
        NotificationCenter.default.post(name: Notification.Name("updateStatisticDataNotification"), object: (startDate, endDate))
        self.contentView = StatisticView(
            frame: .zero,
            chartData: viewModel.getSugarHistoryDay(
                startDate: startDate ?? Date(),
                endDate: endDate ?? Date()
            ),
            lowSugar: viewModel.getMinimalSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            averageSugar: viewModel.getAverageSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            highSugar: viewModel.getMaximalSugarBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            shortInsulinCount: viewModel.getShortInsulinBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            breadCount: viewModel.getBreadCountBy(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
            longInsulinCount: viewModel.getLongInsulinBy(startDate: startDate ?? Date(), endDate: endDate ?? Date())
        )
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
        contentView?.historyTable.delegate = self
        contentView?.historyTable.dataSource = viewModel
        contentView?.historyTable.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        contentView?.layoutSubviews()
        if wasOpened {
            contentView?.timeSegmentControll.selectedSegmentIndex = 0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.contentView?.contentView.transform = .identity
            }
        } else {
            wasOpened.toggle()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView?.scrollToUpside()
    }

    private func updateData(startDate: Date, endDate: Date, for duration: DateDuration) {
        var obtainedChartData: [ChartDataEntry]
        switch duration {
        case .day:
            obtainedChartData = viewModel.getSugarHistoryDay(startDate: startDate, endDate: endDate)
        case .week, .month:
            obtainedChartData = viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate)
        }
        contentView?.updateUI(
            chartData: obtainedChartData.sorted { $0.x < $1.x },
            sugarStats: (
                lowSugar: viewModel.getMinimalSugarBy(startDate: startDate, endDate: endDate),
                averageSugar: viewModel.getAverageSugarBy(startDate: startDate, endDate: endDate),
                highSugar: viewModel.getMaximalSugarBy(startDate: startDate, endDate: endDate)
            ),
            foodStats: (
                shortInsulin: viewModel.getShortInsulinBy(startDate: startDate, endDate: endDate),
                breadCount: viewModel.getBreadCountBy(startDate: startDate, endDate: endDate),
                longInsulin: viewModel.getLongInsulinBy(startDate: startDate, endDate: endDate)
            )
        )
        NotificationCenter.default.post(name: Notification.Name("updateStatisticDataNotification"), object: (startDate, endDate))
        if viewModel.dataSource.count == 0 {
            contentView?.scrollAddition = 345
        } else {
            contentView?.scrollAddition = viewModel.dataSource.count >= 7 ? -30 : CGFloat(385 - 57 * viewModel.dataSource.count)
        }
    }

    private func setUpBinding() {
        contentView?.timeSegmentControll
            .publisher(for: \.selectedSegmentIndex)
            .sink(receiveValue: { [weak self] index in
                switch index {
                case 0:
                    self?.updateDataForDay()
                case 1:
                    self?.updateDataForWeek()
                case 2:
                    self?.updateDataForMonth()
                default:
                    print("Unexpected segmentControll index")
                }
            }
            ).store(in: &subscriptions)
    }

    private func updateDataForDay() {
        guard let endDate = Calendar.current.date(from: getEndOfDayComponents()),
            let startDate = Calendar.current.date(from: getTodayComponents()) else { return }
        let minimalSugar = viewModel.getMinimalSugarBy(startDate: startDate, endDate: endDate).0 - 1
        let maximalSugar = viewModel.getMaximalSugarBy(startDate: startDate, endDate: endDate).0 + 2
        contentView?.chartSubView.chart.xAxis.labelCount = 13
        contentView?.chartSubView.chart.xAxis.axisMinimum = 0.0
        contentView?.chartSubView.chart.xAxis.axisMaximum = 23.0
        contentView?.chartSubView.chart.leftAxis.labelCount = Int(maximalSugar - minimalSugar)
        contentView?.chartSubView.chart.leftAxis.axisMinimum = minimalSugar
        contentView?.chartSubView.chart.leftAxis.axisMaximum = maximalSugar
        contentView?.chartSubView.chart.rightAxis.labelFont = UIFont.systemFont(ofSize: 0)
        updateData(startDate: startDate, endDate: endDate, for: .day)
        contentView?.historyTable.reloadData()
    }

    private func updateDataForWeek() {
        guard let endDate = Calendar.current.date(from: getEndOfDayComponents()),
        let startDate = Calendar.current.date(from: getWeekStartComponents()) else { return }
        let data = viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate)
        guard let startOfChart = data.map({ $0.x}).min(),
            let minimalSugar = data.map({ $0.y}).min(),
            let maximalSugar = data.map({ $0.y}).max() else { return }
        contentView?.chartSubView.chart.xAxis.labelCount = 6
        contentView?.chartSubView.chart.xAxis.axisMinimum = startOfChart
        contentView?.chartSubView.chart.xAxis.axisMaximum = startOfChart + 6
        contentView?.chartSubView.chart.leftAxis.labelCount = Int(maximalSugar - minimalSugar)
        contentView?.chartSubView.chart.leftAxis.axisMinimum = minimalSugar - 1
        contentView?.chartSubView.chart.leftAxis.axisMaximum = maximalSugar + 2
        updateData(startDate: startDate, endDate: endDate, for: .week)
        contentView?.historyTable.reloadData()
    }

    private func updateDataForMonth() {
        guard let endDate = Calendar.current.date(from: getMonthEndComponents()),
            let startDate = Calendar.current.date(from: getMonthStartComponents()) else { return }
        let data = viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate)
        guard let minimalSugar = data.map({ $0.y}).min(),
            let maximalSugar = data.map({ $0.y}).max() else { return }

        contentView?.chartSubView.chart.xAxis.labelCount = 15
        contentView?.chartSubView.chart.xAxis.axisMinimum = 0.0
        contentView?.chartSubView.chart.xAxis.axisMaximum = 30.0
        contentView?.chartSubView.chart.leftAxis.labelCount = Int(maximalSugar - minimalSugar)
        contentView?.chartSubView.chart.leftAxis.axisMinimum = minimalSugar - 1
        contentView?.chartSubView.chart.leftAxis.axisMaximum = maximalSugar + 2
        updateData(startDate: startDate, endDate: endDate, for: .month)
        contentView?.historyTable.reloadData()
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

extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
