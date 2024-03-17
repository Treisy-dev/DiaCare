//
//  NewNoteSugarSubView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.03.2024.
//
import SnapKit
import UIKit

class NewNoteSugarSubView: UIView {

    private lazy var downArrow: UIButton = UIButton()
    private lazy var upArrow: UIButton = UIButton()
    private lazy var sugarView: UIView = UIView()
    lazy var sugarCountLabel: UILabel = UILabel()
    private lazy var sugarLabel: UILabel = UILabel()
    private lazy var bloodIcon: UIImageView = UIImageView()
    private lazy var hintLabel: UILabel = UILabel()

    init(frame: CGRect, avarageSugar: String) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray.withAlphaComponent(0.15)
        self.layer.cornerRadius = 18
        sugarCountLabel.text = avarageSugar
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpSugarLabel()
        setUpBloodIcon()
        setUpSugarView()
        setUpSugarCountLabel()
        setUpDownArrow()
        setUpUpArrow()
        setUpHintLabel()
    }

    private func setUpSugarLabel() {
        addSubview(sugarLabel)
        sugarLabel.text = "Уровень сахара"
        sugarLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sugarLabel.textColor = .black
        sugarLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }

    private func setUpBloodIcon() {
        addSubview(bloodIcon)
        bloodIcon.image = UIImage.bloodFillIcon
        bloodIcon.contentMode = .center
        bloodIcon.snp.makeConstraints { make in
            make.leading.lessThanOrEqualTo(sugarLabel.snp_trailingMargin).offset(10)
            make.trailing.greaterThanOrEqualToSuperview().inset(80)
            make.centerY.equalTo(sugarLabel.snp_centerYWithinMargins)
        }
    }

    private func setUpSugarView() {
        addSubview(sugarView)
        sugarView.layer.cornerRadius = 29
        sugarView.layer.borderWidth = 2
        sugarView.layer.borderColor = UIColor.mainApp.cgColor
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sugarView.addGestureRecognizer(panGesture)

        sugarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sugarLabel.snp_bottomMargin).offset(12)
            make.width.height.equalTo(58)
        }
    }

    private func setUpSugarCountLabel() {
        sugarView.addSubview(sugarCountLabel)
        sugarCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sugarCountLabel.textColor = .mainApp

        sugarCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setUpDownArrow() {
        addSubview(downArrow)
        downArrow.setImage(UIImage.downSugarArrowIcon, for: .normal)
        downArrow.contentMode = .center
        let decreaseAction = UIAction { [weak self] _ in
            guard let sugar = Double(self?.sugarCountLabel.text ?? "8.5") else { return }
            if sugar >= 1.5 {
                self?.sugarCountLabel.text = String(format: "%.1f", sugar - 0.1)
            }
        }
        downArrow.addAction(decreaseAction, for: .touchUpInside)

        downArrow.snp.makeConstraints { make in
            make.trailing.equalTo(sugarView.snp_leadingMargin).inset(-20)
            make.centerY.equalTo(sugarView.snp_centerYWithinMargins)
            make.width.equalTo(16)
            make.height.equalTo(19)
        }
    }

    private func setUpUpArrow() {
        addSubview(upArrow)
        upArrow.setImage(UIImage.upSugarArrowIcon, for: .normal)
        upArrow.contentMode = .center
        let increaseAction = UIAction { [weak self] _ in
            guard let sugar = Double(self?.sugarCountLabel.text ?? "8.5") else { return }
            self?.sugarCountLabel.text = String(format: "%.1f", sugar + 0.1)
        }
        upArrow.addAction(increaseAction, for: .touchUpInside)

        upArrow.snp.makeConstraints { make in
            make.leading.equalTo(sugarView.snp_trailingMargin).inset(-20)
            make.centerY.equalTo(sugarView.snp_centerYWithinMargins)
            make.width.equalTo(16)
            make.height.equalTo(19)
        }
    }

    private func setUpHintLabel() {
        addSubview(hintLabel)
        hintLabel.text = "тяни для изменений"
        hintLabel.font = UIFont.systemFont(ofSize: 11)
        hintLabel.textColor = .lightGray.withAlphaComponent(0.7)

        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(sugarView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: sugarView)

        let velocity = gesture.velocity(in: sugarView)

        if gesture.state == .changed {
            let speedMultiplier: Double = 0.001
            let valueChange = Double(velocity.y) * speedMultiplier
            guard let currentSugar = Double(sugarCountLabel.text ?? "8.5") else { return }
            if currentSugar + valueChange >= 1.5 || velocity.y > 0 {
                sugarCountLabel.text = String(format: "%.1f", currentSugar + valueChange)
            }
        }
    }
}
