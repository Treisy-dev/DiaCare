//
//  ChartSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 07.05.2024.
//
import DGCharts
import SnapKit
import UIKit

final class ChartSubView: UIView {

    lazy var chart: LineChartView = LineChartView()
    private lazy var labelsSwitcher: UISwitch = UISwitch()
    private lazy var switcherHint: UILabel = UILabel()
    private lazy var hintLabel: UILabel = UILabel()

    var chartData: [ChartDataEntry] = []

    init(frame: CGRect, chartData: [ChartDataEntry]) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        self.chartData = chartData
        setUp()
        if chartData.count == 0 {
            chart.isHidden = true
            hintLabel.isHidden = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpChart()
        setUpLabelsSwitcher()
        setUpSwitcherHint()
        setUpHintLabel()
    }

    func updateUI(chartData: [ChartDataEntry]) {
        self.chartData = chartData
        if chartData.count == 0 {
            chart.isHidden = true
            hintLabel.isHidden = false
        } else {
            chart.isHidden = false
            hintLabel.isHidden = true
        }
        updateDataForChart()
    }

    private func setUpChart() {
        addSubview(chart)

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
            make.height.equalTo(210)
        }

        updateDataForChart()
    }

    private func setUpLabelsSwitcher() {
        addSubview(labelsSwitcher)
        labelsSwitcher.onTintColor = .mainApp
        let changeAction: UIAction = UIAction { [weak self] _ in
            self?.updateDataForChart()
        }
        labelsSwitcher.addAction(changeAction, for: .valueChanged)
        labelsSwitcher.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(chart.snp.bottom).offset(10)
        }
    }

    private func setUpSwitcherHint() {
        addSubview(switcherHint)
        switcherHint.textColor = .lightGray
        switcherHint.font = UIFont.systemFont(ofSize: 16)
        switcherHint.text = "Включить подписи значений"
        switcherHint.snp.makeConstraints { make in
            make.leading.equalTo(labelsSwitcher.snp.trailing).offset(10)
            make.centerY.equalTo(labelsSwitcher.snp.centerY)
        }
    }

    private func setUpHintLabel() {
        addSubview(hintLabel)
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

    func updateDataForChart() {
        let dataSet: LineChartDataSet = LineChartDataSet(entries: chartData)

        dataSet.mode = .linear
        if labelsSwitcher.isOn {
            dataSet.valueFont = UIFont.systemFont(ofSize: 10)
            switcherHint.text = "Выключить подписи значений"
        } else {
            dataSet.valueFont = UIFont.systemFont(ofSize: 0)
            switcherHint.text = "Включить подписи значений"
        }
        dataSet.lineWidth = 2.0
        dataSet.circleRadius = 4.0
        dataSet.circleColors = [UIColor.mainApp]
        dataSet.fillColor = .clear
        dataSet.colors = [.mainApp]
        dataSet.valueFormatter = CustomDataFormater()

        chart.data = LineChartData(dataSet: dataSet)
    }
}
