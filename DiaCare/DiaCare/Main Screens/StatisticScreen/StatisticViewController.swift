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
    }

    private func setUpBinding() {
        contentView?.timeSegmentControll
            .publisher(for: \.selectedSegmentIndex)
            .sink(receiveValue: { [weak self] index in
                switch index {
                case 0:
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
                    guard let endDate,
                        let startDate,
                        let data = self?.viewModel.getSugarHistoryDay(startDate: startDate, endDate: endDate) else { return }
                    self?.contentView?.chartData = data.sorted {$0.x < $1.x}
                    self?.contentView?.chart.xAxis.labelCount = 12
                    self?.contentView?.chart.xAxis.axisMinimum = 0.0
                    self?.contentView?.chart.xAxis.axisMaximum = 22.0
                case 1:
                    var startComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    startComponents.day = (startComponents.day ?? 7) - 6
                    startComponents.hour = 0
                    startComponents.minute = 0
                    startComponents.second = 0
                    let startDate = Calendar.current.date(from: startComponents)
                    var endComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    endComponents.hour = 23
                    endComponents.minute = 59
                    endComponents.second = 59
                    let endDate = Calendar.current.date(from: endComponents)
                    guard let endDate,
                        let startDate,
                        let data = self?.viewModel.getSugarHistoryWeek(startDate: startDate, endDate: endDate) else { return }
                    self?.contentView?.chartData = data.sorted {$0.x < $1.x}
                    self?.contentView?.chart.xAxis.labelCount = 7
                    self?.contentView?.chart.xAxis.axisMinimum = 0.0
                    self?.contentView?.chart.xAxis.axisMaximum = 7.0
                case 2:
                    var startComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    startComponents.day = 1
                    startComponents.hour = 0
                    startComponents.minute = 0
                    startComponents.second = 0
                    let startDate = Calendar.current.date(from: startComponents)
                    var endComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    endComponents.day = 30
                    endComponents.hour = 23
                    endComponents.minute = 59
                    endComponents.second = 59
                    let endDate = Calendar.current.date(from: endComponents)
                    guard let endDate,
                        let startDate,
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
}
