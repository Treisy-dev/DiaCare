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

    func makeSugarHStack(
        withLabel lableText: String,
        withImage image: UIImage,
        withCountLable countLableText: String) -> UIStackView {
            let hStack = UIStackView()
            let lable = UILabel()
            let imageView = UIImageView()
            let countLable = UILabel()
            hStack.axis = .horizontal
            hStack.spacing = 10

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
            let attributedString = NSMutableAttributedString(string: countLableText)
            attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.black,
                range: NSRange(location: 0, length: 4))
            attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.mainApp,
                range: NSRange(location: 4, length: countLableText.count - 4))
            countLable.attributedText = attributedString

            hStack.addArrangedSubview(countLable)

            return hStack
        }
}
