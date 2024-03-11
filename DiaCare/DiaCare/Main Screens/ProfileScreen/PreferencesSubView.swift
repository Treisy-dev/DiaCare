//
//  PreferencesSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//
import SnapKit
import UIKit

class PreferencesSubView: UIView {

    lazy var preferencesVStack: UIStackView = UIStackView()
    lazy var preferencesLable: UILabel = UILabel()

    lazy var underlineView: CustomUnderlineView = CustomUnderlineView(frame: CGRect(x: 0, y: 0, width: 300, height: 1))

    init(frame: CGRect, targetSugarText: String, highSugarText: String, lowSugarText: String) {
        super.init(frame: frame)
        setUpProfileVStack(targetSugarText: targetSugarText, highSugarText: highSugarText, lowSugarText: lowSugarText)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpProfileVStack(targetSugarText: String, highSugarText: String, lowSugarText: String) {
        addSubview(preferencesVStack)
        preferencesVStack.axis = .vertical
        preferencesVStack.spacing = 15

        preferencesLable.text = "Предпочтения:"
        preferencesLable.font = UIFont.systemFont(ofSize: 16)
        preferencesLable.textColor = .black

        preferencesVStack.addArrangedSubview(preferencesLable)
        preferencesVStack.addArrangedSubview(PreferencesHStackFabric.shared.makeSugarHStack(
            withLabel: "Целевой сахар",
            withImage: UIImage.targetIcon,
            withCountLable: targetSugarText))
        preferencesVStack.addArrangedSubview(PreferencesHStackFabric.shared.makeSugarHStack(
            withLabel: "Высокий сахар",
            withImage: UIImage.highSugarIcon,
            withCountLable: highSugarText))
        preferencesVStack.addArrangedSubview(PreferencesHStackFabric.shared.makeSugarHStack(
            withLabel: "Низкий сахар",
            withImage: UIImage.lowSugarIcon,
            withCountLable: lowSugarText))

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
