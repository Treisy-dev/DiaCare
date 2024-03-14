//
//  SugarHStackBuilder.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 12.03.2024.
//

import SnapKit
import UIKit

class PreferencesHStackFabric {
    public static let shared = PreferencesHStackFabric()

    private init() {
    }

    func makeHStackWithIcon(
        withLabel lableText: String,
        withImage image: UIImage,
        withCountLable countLableText: String?,
        coloredText: String) -> UIStackView {
            let hStack = UIStackView()
            let lable = UILabel()
            let imageView = UIImageView()
            let countLable = UILabel()
            let coloredLabel = UILabel()
            hStack.axis = .horizontal
            hStack.distribution = .equalSpacing

            imageView.image = image
            imageView.contentMode = .center
            imageView.snp.makeConstraints { make in
                make.width.equalTo(25)
            }
            hStack.addArrangedSubview(imageView)

            lable.font = UIFont.systemFont(ofSize: 16)
            lable.textColor = .black
            lable.text = lableText
            lable.snp.makeConstraints { make in
                make.width.equalTo(150)
            }

            hStack.addArrangedSubview(lable)

            countLable.font = UIFont.systemFont(ofSize: 16)
            countLable.text = countLableText
            coloredLabel.text = coloredText
            coloredLabel.textColor = .mainApp
            coloredLabel.font = UIFont.systemFont(ofSize: 16)
            coloredLabel.minimumScaleFactor = 0.5
            coloredLabel.adjustsFontSizeToFitWidth = true

            hStack.addArrangedSubview(countLable)
            hStack.addArrangedSubview(coloredLabel)

            return hStack
        }

    func makeFoodHStack(
        withLabel lableText: String,
        withCountLable countLableText: String,
        coloredText: String) -> UIStackView {
            let hStack = UIStackView()
            let lable = UILabel()
            let countLable = UILabel()
            let coloredLabel = UILabel()
            hStack.axis = .horizontal
            hStack.distribution = .equalSpacing

            lable.font = UIFont.systemFont(ofSize: 16)
            lable.textColor = .black
            lable.text = lableText
            lable.snp.makeConstraints { make in
                make.width.equalTo(185)
            }

            hStack.addArrangedSubview(lable)

            countLable.font = UIFont.systemFont(ofSize: 16)
            countLable.text = countLableText
            coloredLabel.text = coloredText
            coloredLabel.textColor = .mainApp
            coloredLabel.font = UIFont.systemFont(ofSize: 16)

            hStack.addArrangedSubview(countLable)
            hStack.addArrangedSubview(coloredLabel)

            return hStack
        }
}
