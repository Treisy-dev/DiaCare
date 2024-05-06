//
//  CustomFoodStatisticView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 05.05.2024.
//
import SnapKit
import UIKit

class CustomFoodStatisticView: UIView {

    private lazy var titleLabel: UILabel = UILabel()
    private lazy var countLabel: UILabel = UILabel()
    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var whiteCircle: UIView = UIView()

    init(frame: CGRect, countLabel: String, titleLabel: String) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        self.titleLabel.text = titleLabel
        self.countLabel.text = countLabel
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        layer.cornerRadius = 10
        setUp()
    }

    private func setUp() {
        setUpGradientView()
        setUpWhiteCircle()
        setUpCountLabel()
        setUpTitleLabel()
    }

    func updateUI(countLabel: String) {
        self.countLabel.text = countLabel
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.layer.cornerRadius = 37.5
        gradientView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(75)
        }
    }

    private func setUpWhiteCircle() {
        gradientView.addSubview(whiteCircle)
        whiteCircle.layer.cornerRadius = 25
        whiteCircle.backgroundColor = .white

        whiteCircle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }

    private func setUpCountLabel() {
        whiteCircle.addSubview(countLabel)
        countLabel.font = UIFont.boldSystemFont(ofSize: 16)
        countLabel.textColor = .mainApp

        countLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setUpTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
}
