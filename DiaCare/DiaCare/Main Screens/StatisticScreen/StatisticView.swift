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
    lazy var contentView: UIView = UIView()
    private lazy var statisticLabel: UILabel = UILabel()
    lazy var timeSegmentControll: UISegmentedControl = UISegmentedControl(items: ["День", "Неделя", "Месяц"])
    var chartSubView: ChartSubView
    private lazy var sugarLabel: UILabel = UILabel()
    var sugarStatsSubView: SugarStatsSubView
    private lazy var averageFoodStatsLabel: UILabel = UILabel()
    var foodStatsSubView: FoodStatsSubView
    private lazy var historyLabel: UILabel = UILabel()
    lazy var historyTable: UITableView = UITableView()
    private lazy var historyHintLabel: UILabel = UILabel()

    var scrollAddition: CGFloat = 0
    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?

    init(
        frame: CGRect,
        chartData: [ChartDataEntry],
        lowSugar: (Double, SugarState),
        averageSugar: (Double, SugarState),
        highSugar: (Double, SugarState),
        shortInsulinCount: Double,
        breadCount: Double,
        longInsulinCount: Double) {
            self.chartSubView = ChartSubView(frame: .zero, chartData: chartData)
            self.sugarStatsSubView = SugarStatsSubView(frame: .zero, lowSugar: lowSugar, averageSugar: averageSugar, highSugar: highSugar)
            self.foodStatsSubView = FoodStatsSubView(
                frame: .zero,
                shortInsulinCount: shortInsulinCount,
                breadCount: breadCount,
                longInsulinCount: longInsulinCount)
            super.init(frame: frame)
            backgroundColor = .white.withAlphaComponent(0.96)
            setUp()
            if chartData.count == 0 {
                historyTable.isHidden = true
                historyHintLabel.isHidden = false
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
        setUpChartSubView()
        setUpSugarLabel()
        setUpSugarStatsSubView()
        setUpAverageFoodStatsLabel()
        setUpFoodStatsSubView()
        setUpHistoryLabel()
        setUpHistoryTable()
        setUpHistoryHintLabel()
    }

    func updateUI(
        chartData: [ChartDataEntry],
        sugarStats: (lowSugar: (Double, SugarState), averageSugar: (Double, SugarState), highSugar: (Double, SugarState)),
        foodStats: (shortInsulin: Double, breadCount: Double, longInsulin: Double)) {
            self.chartSubView.updateUI(chartData: chartData)
            sugarStatsSubView.lowSugarView.updateUI(
                countLabel: String(format: "%.1f", sugarStats.lowSugar.0),
                sugarState: sugarStats.lowSugar.1)
            sugarStatsSubView.averageSugarView.updateUI(
                countLabel: String(format: "%.1f", sugarStats.averageSugar.0),
                sugarState: sugarStats.averageSugar.1)
            sugarStatsSubView.highSugarView.updateUI(
                countLabel: String(format: "%.1f", sugarStats.highSugar.0),
                sugarState: sugarStats.highSugar.1)
            foodStatsSubView.shortInsulinStatView.updateUI(countLabel: String(format: "%.1f", foodStats.shortInsulin))
            foodStatsSubView.breadCountStatView.updateUI(countLabel: String(format: "%.1f", foodStats.breadCount))
            foodStatsSubView.longInsulinStatView.updateUI(countLabel: String(format: "%.1f", foodStats.longInsulin))
            if chartData.count == 0 {
                historyTable.isHidden = true
                historyHintLabel.isHidden = false
            } else {
                historyTable.isHidden = false
                historyHintLabel.isHidden = true
            }
    }

    private func setUpContentView() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1320)
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

    private func setUpChartSubView() {
        contentView.addSubview(chartSubView)
        chartSubView.snp.makeConstraints { make in
            make.top.equalTo(timeSegmentControll.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(270)
        }
    }

    private func setUpSugarLabel() {
        contentView.addSubview(sugarLabel)
        sugarLabel.text = "Сахар"
        sugarLabel.textColor = .black
        sugarLabel.font = UIFont.boldSystemFont(ofSize: 16)

        sugarLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(chartSubView.snp.bottom).offset(20)
        }
    }

    private func setUpSugarStatsSubView() {
        contentView.addSubview(sugarStatsSubView)
        sugarStatsSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().inset(38)
            make.height.equalTo(115)
            make.top.equalTo(sugarLabel.snp.bottom).offset(15)
        }
    }

    private func setUpAverageFoodStatsLabel() {
        contentView.addSubview(averageFoodStatsLabel)
        averageFoodStatsLabel.text = "Средние показатели"
        averageFoodStatsLabel.textColor = .black
        averageFoodStatsLabel.font = UIFont.boldSystemFont(ofSize: 16)

        averageFoodStatsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sugarStatsSubView.snp.bottom).offset(20)
        }
    }

    private func setUpFoodStatsSubView() {
        contentView.addSubview(foodStatsSubView)
        foodStatsSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(145)
            make.top.equalTo(averageFoodStatsLabel.snp.bottom).offset(15)
        }
    }

    private func setUpHistoryLabel() {
        contentView.addSubview(historyLabel)
        historyLabel.text = "История"
        historyLabel.textColor = .black
        historyLabel.font = UIFont.boldSystemFont(ofSize: 16)

        historyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(foodStatsSubView.snp.bottom).offset(20)
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

    private func setUpHistoryHintLabel() {
        contentView.addSubview(historyHintLabel)
        historyHintLabel.text = "У вас пока нет добавленных записей"
        historyHintLabel.textColor = .lightGray
        historyHintLabel.numberOfLines = 2
        historyHintLabel.lineBreakMode = .byWordWrapping
        historyHintLabel.textAlignment = .center
        historyHintLabel.font = UIFont.systemFont(ofSize: 24)
        historyHintLabel.isHidden = true

        historyHintLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(historyLabel.snp.bottom).offset(15)
        }
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        chartSubView.updateDataForChart()
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = contentView.frame.maxY
            initialTransform = contentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 1320 && newMaxY >= 780 + scrollAddition {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                contentView.transform = newTransform
            }
        }
    }
}
