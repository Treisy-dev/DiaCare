//
//  NewTemplateStatsSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class NewTemplateStatsSubView: UIView {

    lazy var proteinVStack: UIStackView = ProductVStackFabric.shared.makeCircledProductPropVStack(
        titleLabel: "Белки",
        titleLabelColor: .systemYellow,
        count: "0"
    )
    lazy var fatVStack: UIStackView = ProductVStackFabric.shared.makeCircledProductPropVStack(
        titleLabel: "Жиры",
        titleLabelColor: .systemBlue,
        count: "0"
    )
    lazy var carbsVStack: UIStackView = ProductVStackFabric.shared.makeCircledProductPropVStack(
        titleLabel: "Углеводы",
        titleLabelColor: .systemRed,
        count: "0"
    )
    lazy var breadCountVStack: UIStackView = ProductVStackFabric.shared.makeCircledProductPropVStack(
        titleLabel: "ХЕ",
        titleLabelColor: .systemGreen,
        count: "0"
    )
    lazy var insulinVStack: UIStackView = ProductVStackFabric.shared.makeCircledProductPropVStack(
        titleLabel: "Инсулин",
        titleLabelColor: .purple,
        count: "0"
    )

    private lazy var summaryLabel: UILabel = UILabel()
    private lazy var statsHStack: UIStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpSummaryLabel()
        setUpStatsHStack()
    }

    private func setUpSummaryLabel() {
        addSubview(summaryLabel)
        summaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        summaryLabel.text = "Итого:"
        summaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }

    private func setUpStatsHStack() {
        addSubview(statsHStack)
        statsHStack.axis = .horizontal
        statsHStack.distribution = .equalSpacing
        statsHStack.alignment = .center
        statsHStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(summaryLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }

        statsHStack.addArrangedSubview(proteinVStack)
        statsHStack.addArrangedSubview(fatVStack)
        statsHStack.addArrangedSubview(carbsVStack)
        statsHStack.addArrangedSubview(breadCountVStack)
        statsHStack.addArrangedSubview(insulinVStack)
    }
}
