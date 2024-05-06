//
//  SugarStatisticView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 05.05.2024.
//
import SnapKit
import UIKit

enum SugarState {
    case good
    case normal
    case bad
}

final class CustomSugarStatisticView: UIView {

    private lazy var levelLabel: UILabel = UILabel()
    private lazy var sugarCountLabel: UILabel = UILabel()
    private lazy var sugarDimensionLabel: UILabel = UILabel()
    private lazy var stateHStack: UIStackView = UIStackView()
    private lazy var coloredView: UIView = UIView()
    private lazy var stateLabel: UILabel = UILabel()

    init(frame: CGRect, levelName: String, sugarCount: String, sugarState: SugarState) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        levelLabel.text = levelName
        sugarCountLabel.text = sugarCount
        switch sugarState {
        case .good:
            coloredView.backgroundColor = .green
            stateLabel.text = "отлично"
        case .normal:
            coloredView.backgroundColor = .yellow
            stateLabel.text = "хорошо"
        case .bad:
            coloredView.backgroundColor = .red
            stateLabel.text = "плохо"
        }
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        layer.cornerRadius = 10
        setUp()
    }

    private func setUp() {
        setUpLevelLabel()
        setUpSugarCountLabel()
        setUpSugarDimensionLabel()
        setUpStateHStack()
    }

    func updateUI(countLabel: String, sugarState: SugarState) {
        sugarCountLabel.text = countLabel
        switch sugarState {
        case .good:
            coloredView.backgroundColor = .green
            stateLabel.text = "отлично"
        case .normal:
            coloredView.backgroundColor = .yellow
            stateLabel.text = "хорошо"
        case .bad:
            coloredView.backgroundColor = .red
            stateLabel.text = "плохо"
        }
    }

    private func setUpLevelLabel() {
        addSubview(levelLabel)
        levelLabel.textAlignment = .center
        levelLabel.font = UIFont.systemFont(ofSize: 16)

        levelLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(6)
        }
    }

    private func setUpSugarCountLabel() {
        addSubview(sugarCountLabel)
        sugarCountLabel.textAlignment = .center
        sugarCountLabel.font = UIFont.systemFont(ofSize: 16)

        sugarCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(levelLabel.snp.bottom).offset(10)
        }
    }

    private func setUpSugarDimensionLabel() {
        addSubview(sugarDimensionLabel)
        sugarDimensionLabel.textAlignment = .center
        sugarDimensionLabel.font = UIFont.systemFont(ofSize: 12)
        sugarDimensionLabel.text = "ммоль/л"

        sugarDimensionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sugarCountLabel.snp.bottom).offset(4)
        }
    }

    private func setUpStateHStack() {
        addSubview(stateHStack)
        stateHStack.axis = .horizontal
        stateHStack.spacing = 4
        stateHStack.alignment = .center

        stateHStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(5)
            make.top.equalTo(sugarDimensionLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().inset(5)
        }
        setUpColoredView()
        setUpStateLabel()
    }

    private func setUpColoredView() {
        stateHStack.addArrangedSubview(coloredView)
        coloredView.layer.cornerRadius = 5.5

        coloredView.snp.makeConstraints { make in
            make.height.width.equalTo(11)
        }
    }

    private func setUpStateLabel() {
        stateHStack.addArrangedSubview(stateLabel)
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
