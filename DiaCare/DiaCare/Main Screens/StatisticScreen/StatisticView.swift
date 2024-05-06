//
//  StatisticView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit
import DGCharts

final class StatisticView: UIView {

    private lazy var contentView: UIView = UIView()
    private lazy var statisticLabel: UILabel = UILabel()
    private lazy var chartView: UIView = UIView()
    lazy var timeSegmentControll: UISegmentedControl = UISegmentedControl(items: ["День", "Неделя", "Месяц"])
    lazy var chart: LineChartView = LineChartView()
    private lazy var sugarLabel: UILabel = UILabel()
    private lazy var sugarStatsHStack: UIStackView = UIStackView()
    private var lowSugarView: CustomSugarStatisticView
    private var averageSugarView: CustomSugarStatisticView
    private var highSugarView: CustomSugarStatisticView
    private lazy var averageFoodStatsLabel: UILabel = UILabel()
    private lazy var foodStatsHStack: UIStackView = UIStackView()
    private var shortInsulinStatView: CustomFoodStatisticView
    private var breadCountStatView: CustomFoodStatisticView
    private var longInsulinStatView: CustomFoodStatisticView
    private lazy var hintLabel: UILabel = UILabel()
    private lazy var historyLabel: UILabel = UILabel()
    lazy var historyTable: UITableView = UITableView()

    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?
    var chartData: [ChartDataEntry] = []

    init(
        frame: CGRect,
        chartData: [ChartDataEntry],
        lowSugar: (Double, SugarState),
        averageSugar: (Double, SugarState),
        highSugar: (Double, SugarState),
        shortInsulinCount: Double,
        breadCount: Double,
        longInsulinCount: Double) {
            self.chartData = chartData
            self.lowSugarView = CustomSugarStatisticView(
                frame: .zero,
                levelName: "Низкий",
                sugarCount: String(format: "%.1f", lowSugar.0),
                sugarState: lowSugar.1)
            self.averageSugarView = CustomSugarStatisticView(
                frame: .zero,
                levelName: "Средний",
                sugarCount: String(format: "%.1f", averageSugar.0),
                sugarState: averageSugar.1)
            self.highSugarView = CustomSugarStatisticView(
                frame: .zero,
                levelName: "Высокий",
                sugarCount: String(format: "%.1f", highSugar.0),
                sugarState: highSugar.1)
            self.shortInsulinStatView = CustomFoodStatisticView(
                frame: .zero,
                countLabel: String(format: "%.1f", shortInsulinCount),
                titleLabel: "Короткий инсулин")
            self.breadCountStatView = CustomFoodStatisticView(
                frame: .zero,
                countLabel: String(format: "%.1f", breadCount),
                titleLabel: "Хлебные единицы")
            self.longInsulinStatView = CustomFoodStatisticView(
                frame: .zero,
                countLabel: String(format: "%.1f", longInsulinCount),
                titleLabel: "Длинный инсулин")
            super.init(frame: frame)
            backgroundColor = .white.withAlphaComponent(0.96)
            setUp()
            if chartData.count == 0 {
                self.chart.isHidden = true
                self.hintLabel.isHidden = false
            }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if panGestureRecognizer == nil {
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            guard let panGestureRecognizer else {return}
            contentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpContentView()
        setUpStatisticLabel()
        setUpTimeSegmentControll()
        setUpChartView()
        setUpChart()
        setUpSugarLabel()
        setUpSugarStatsHStack()
        setUpAverageFoodStatsLabel()
        setUpFoodStatsHStack()
        showHintLabel()
        setUpHistoryLabel()
        setUpHistoryTable()
    }

    func updateUI(
        chartData: [ChartDataEntry],
        sugarStats: (lowSugar: (Double, SugarState), averageSugar: (Double, SugarState), highSugar: (Double, SugarState)),
        foodStats: (shortInsulin: Double, breadCount: Double, longInsulin: Double)) {
            self.chartData = chartData
            lowSugarView.updateUI(countLabel: String(format: "%.1f", sugarStats.lowSugar.0), sugarState: sugarStats.lowSugar.1)
            averageSugarView.updateUI(countLabel: String(format: "%.1f", sugarStats.averageSugar.0), sugarState: sugarStats.averageSugar.1)
            highSugarView.updateUI(countLabel: String(format: "%.1f", sugarStats.highSugar.0), sugarState: sugarStats.highSugar.1)
            shortInsulinStatView.updateUI(countLabel: String(format: "%.1f", foodStats.shortInsulin))
            breadCountStatView.updateUI(countLabel: String(format: "%.1f", foodStats.breadCount))
            longInsulinStatView.updateUI(countLabel: String(format: "%.1f", foodStats.longInsulin))
            updateDataForChart()
            if chartData.count == 0 {
                chart.isHidden = true
                hintLabel.isHidden = false
            } else {
                chart.isHidden = false
                hintLabel.isHidden = true
            }
    }

    private func setUpContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1279)
        }
    }

    private func setUpStatisticLabel() {
        contentView.addSubview(statisticLabel)
        statisticLabel.text = "Статистика"
        statisticLabel.textColor = .black
        statisticLabel.font = UIFont.boldSystemFont(ofSize: 24)
        statisticLabel.textAlignment = .center

        statisticLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
    }

    private func setUpTimeSegmentControll() {
        contentView.addSubview(timeSegmentControll)
        timeSegmentControll.selectedSegmentIndex = 0
        timeSegmentControll.tintColor = .mainApp

        let font = UIFont.systemFont(ofSize: 16)
        timeSegmentControll.selectedSegmentTintColor = .mainApp
        timeSegmentControll.setTitleTextAttributes([.foregroundColor: UIColor.mainApp, .font: font], for: .normal)
        timeSegmentControll.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: font], for: .selected)

        timeSegmentControll.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)

        timeSegmentControll.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(statisticLabel.snp.bottom).offset(20)
        }
    }

    private func setUpChartView() {
        contentView.addSubview(chartView)
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 10

        chartView.snp.makeConstraints { make in
            make.top.equalTo(timeSegmentControll.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(220)
        }
    }

    private func setUpChart() {
        chartView.addSubview(chart)

        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.labelPosition = .outsideChart
        chart.legend.enabled = false
        chart.xAxis.gridColor = .mainApp
        chart.leftAxis.gridColor = .mainApp
        chart.isUserInteractionEnabled = false

        chart.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }

        updateDataForChart()
    }

    private func setUpSugarLabel() {
        contentView.addSubview(sugarLabel)
        sugarLabel.text = "Сахар"
        sugarLabel.textColor = .black
        sugarLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sugarLabel.textAlignment = .center

        sugarLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(chartView.snp.bottom).offset(20)
        }
    }

    private func setUpSugarStatsHStack() {
        contentView.addSubview(sugarStatsHStack)
        sugarStatsHStack.axis = .horizontal
        sugarStatsHStack.distribution = .equalSpacing
        sugarStatsHStack.backgroundColor = .clear

        sugarStatsHStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().inset(38)
            make.height.equalTo(115)
            make.top.equalTo(sugarLabel.snp.bottom).offset(15)
        }
        setUpLowSugarView()
        setUpAverageSugarView()
        setUpHighSugarView()
    }

    private func setUpLowSugarView() {
        sugarStatsHStack.addArrangedSubview(lowSugarView)
        lowSugarView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpAverageSugarView() {
        sugarStatsHStack.addArrangedSubview(averageSugarView)
        averageSugarView.contentMode = .scaleAspectFill
        averageSugarView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpHighSugarView() {
        sugarStatsHStack.addArrangedSubview(highSugarView)
        highSugarView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpAverageFoodStatsLabel() {
        contentView.addSubview(averageFoodStatsLabel)
        averageFoodStatsLabel.text = "Средние показатели"
        averageFoodStatsLabel.textColor = .black
        averageFoodStatsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        averageFoodStatsLabel.textAlignment = .center

        averageFoodStatsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sugarStatsHStack.snp.bottom).offset(20)
        }
    }

    private func setUpFoodStatsHStack() {
        contentView.addSubview(foodStatsHStack)
        foodStatsHStack.axis = .horizontal
        foodStatsHStack.distribution = .equalSpacing
        foodStatsHStack.backgroundColor = .clear

        foodStatsHStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(145)
            make.top.equalTo(averageFoodStatsLabel.snp.bottom).offset(15)
        }
        setUpShortInsulinStatView()
        setUpBreadCountStatView()
        setUpLongInsulinStatView()
    }

    private func setUpShortInsulinStatView() {
        foodStatsHStack.addArrangedSubview(shortInsulinStatView)
        shortInsulinStatView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpBreadCountStatView() {
        foodStatsHStack.addArrangedSubview(breadCountStatView)
        breadCountStatView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpLongInsulinStatView() {
        foodStatsHStack.addArrangedSubview(longInsulinStatView)
        longInsulinStatView.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.top.bottom.equalToSuperview()
        }
    }

    private func setUpHistoryLabel() {
        contentView.addSubview(historyLabel)
        historyLabel.text = "История"
        historyLabel.textColor = .black
        historyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        historyLabel.textAlignment = .center

        historyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(foodStatsHStack.snp.bottom).offset(20)
        }
    }

    private func setUpHistoryTable() {
        contentView.addSubview(historyTable)
        historyTable.showsVerticalScrollIndicator = false
        historyTable.separatorColor = .clear
        historyTable.backgroundColor = .clear
        historyTable.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(historyLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        updateDataForChart()
    }

    private func updateDataForChart() {
        let dataSet: LineChartDataSet = LineChartDataSet(entries: chartData)

        dataSet.mode = .linear
        dataSet.valueFont = UIFont.systemFont(ofSize: 10)
        dataSet.lineWidth = 2.0
        dataSet.circleRadius = 4.0
        dataSet.circleColors = [UIColor.mainApp]
        dataSet.fillColor = .clear
        dataSet.colors = [.mainApp]

        chart.data = LineChartData(dataSet: dataSet)
    }

    private func showHintLabel() {
        chartView.addSubview(hintLabel)
        hintLabel.text = "У вас пока нет добавленных записей"
        hintLabel.textColor = .lightGray
        hintLabel.numberOfLines = 2
        hintLabel.lineBreakMode = .byWordWrapping
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont.systemFont(ofSize: 24)
        hintLabel.isHidden = true

        hintLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = contentView.frame.maxY
            initialTransform = contentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 1270 && newMaxY >= 730 {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                contentView.transform = newTransform
            }
        }
    }
}
