//
//  SugarStatsSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 07.05.2024.
//
import SnapKit
import UIKit

final class SugarStatsSubView: UIView {

    private lazy var sugarStatsHStack: UIStackView = UIStackView()
    var lowSugarView: CustomSugarStatisticView
    var averageSugarView: CustomSugarStatisticView
    var highSugarView: CustomSugarStatisticView

    init(frame: CGRect, lowSugar: (Double, SugarState), averageSugar: (Double, SugarState), highSugar: (Double, SugarState)) {
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
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpSugarStatsHStack()
    }

    private func setUpSugarStatsHStack() {
        addSubview(sugarStatsHStack)
        sugarStatsHStack.axis = .horizontal
        sugarStatsHStack.distribution = .equalSpacing
        sugarStatsHStack.backgroundColor = .clear

        sugarStatsHStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
}
