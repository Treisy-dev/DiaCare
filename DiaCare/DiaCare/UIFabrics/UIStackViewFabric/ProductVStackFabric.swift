//
//  ProductHStackFabric.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 28.03.2024.
//

import UIKit

final class ProductVStackFabric {
    public static let shared = ProductVStackFabric()

    private init() {
    }

    func makeProductPropVStack(titleLabel: String, titleLabelColor: UIColor, count: String) -> UIStackView {
        let vStack = UIStackView()
        let label = UILabel()
        let countLabel = UILabel()

        vStack.axis = .vertical
        vStack.alignment = .center
        label.text = titleLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = titleLabelColor.withAlphaComponent(0.5)

        countLabel.text = count
        countLabel.font = UIFont.systemFont(ofSize: 14)
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(countLabel)

        return vStack
    }

    func makeCircledProductPropVStack(titleLabel: String, titleLabelColor: UIColor, count: String) -> UIStackView {
        let vStack = UIStackView()
        let label = UILabel()
        let circelView = CustomCircledView(frame: .zero, color: titleLabelColor.withAlphaComponent(0.5), count: count)
        circelView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }

        vStack.axis = .vertical
        vStack.alignment = .center
        label.text = titleLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = titleLabelColor.withAlphaComponent(0.5)

        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(circelView)

        return vStack
    }
}
