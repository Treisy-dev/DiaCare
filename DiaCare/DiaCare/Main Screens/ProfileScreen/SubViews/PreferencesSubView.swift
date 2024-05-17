//
//  PreferencesSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//
import SnapKit
import UIKit

final class PreferencesSubView: UIView {
    
    let preferencesHSFabric: PreferencesHStackFabricProtocol

    private lazy var preferencesVStack: UIStackView = UIStackView()
    private lazy var preferencesLable: UILabel = UILabel()

    private lazy var underlineView: CustomUnderlineView = CustomUnderlineView(
        frame: CGRect(x: 0, y: 0, width: 300, height: 1))

    init(
        frame: CGRect,
        targetSugarText: String,
        highSugarText: String,
        lowSugarText: String,
        foodText: String,
        insulinText: String,
        preferenceHStackFabric: PreferencesHStackFabricProtocol) {
        preferencesHSFabric = preferenceHStackFabric
        super.init(frame: frame)
        setUpProfileVStack(
            targetSugarText: targetSugarText,
            highSugarText: highSugarText,
            lowSugarText: lowSugarText,
            foodText: foodText,
            insulinText: insulinText)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpProfileVStack(
        targetSugarText: String,
        highSugarText: String,
        lowSugarText: String,
        foodText: String,
        insulinText: String) {
        addSubview(preferencesVStack)
        preferencesVStack.axis = .vertical
        preferencesVStack.spacing = 15

        preferencesLable.text = "Предпочтения:"
        preferencesLable.font = UIFont.systemFont(ofSize: 16)
        preferencesLable.textColor = .black

        preferencesVStack.addArrangedSubview(preferencesLable)
        preferencesVStack.addArrangedSubview(preferencesHSFabric.makeHStackWithIcon(
            withLabel: "Целевой сахар",
            withImage: UIImage.targetIcon,
            withCountLable: targetSugarText,
            coloredText: "ммоль/л"))
        preferencesVStack.addArrangedSubview(preferencesHSFabric.makeHStackWithIcon(
            withLabel: " Высокий сахар",
            withImage: UIImage.highSugarIcon,
            withCountLable: highSugarText,
            coloredText: "ммоль/л"))
        preferencesVStack.addArrangedSubview(preferencesHSFabric.makeHStackWithIcon(
            withLabel: "Низкий сахар",
            withImage: UIImage.lowSugarIcon,
            withCountLable: lowSugarText,
            coloredText: "ммоль/л"))
        preferencesVStack.addArrangedSubview(preferencesHSFabric.makeFoodHStack(
            withLabel: "Углеводов в ХЕ",
            withCountLable: foodText,
            coloredText: "единиц"))
        preferencesVStack.addArrangedSubview(preferencesHSFabric.makeFoodHStack(
            withLabel: "Инсулин на ХЕ",
            withCountLable: insulinText,
            coloredText: "единиц"))

        preferencesVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(preferencesVStack.snp_bottomMargin).offset(20)
            make.leading.equalTo(preferencesVStack.snp_leadingMargin)
        }
    }
}
