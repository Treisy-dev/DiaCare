//
//  NotificationView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

final class NotificationView: UIView {
    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var titleLable: UILabel = UILabel()
    lazy var notificationContentView: UIView = UIView()
    private lazy var doctorImageView: UIImageView = UIImageView()
    private lazy var addNotifyButton: CustomAddFoodButton = CustomAddFoodButton(frame: frame, title: "Добавить напоминание")
    lazy var notificationTableView: UITableView = UITableView()
    lazy var hintLabel: UILabel = UILabel()

    var addButtonTapped: (() -> Void)?

    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if panGestureRecognizer == nil {
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            guard let panGestureRecognizer else {return}
            notificationContentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    private func setUp() {
        setUpGradientView()
        setUpNotificationImageView()
        setUpNotificationContentView()
        setUpTitleLable()
        setUpAddNotifyButton()
        setUpNotificationTableView()
        setUpHintLabel()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }

    private func setUpNotificationContentView() {
        addSubview(notificationContentView)
        notificationContentView.layer.cornerRadius = 40
        notificationContentView.backgroundColor = .white
        notificationContentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(doctorImageView.snp.bottom).offset(10)
            make.height.equalTo(500)
        }
    }

    private func setUpTitleLable() {
        notificationContentView.addSubview(titleLable)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textColor = .black
        titleLable.text = "Напоминания"

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpNotificationImageView() {
        addSubview(doctorImageView)
        doctorImageView.image = UIImage.notification
        doctorImageView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(80)
            make.leading.equalTo(safeAreaLayoutGuide).offset(80)
            make.top.equalToSuperview().offset(59)
            make.height.equalTo(220)
        }
    }

    private func setUpAddNotifyButton() {
        notificationContentView.addSubview(addNotifyButton)

        let addNotifyAction: UIAction = UIAction { [weak self] _ in
            self?.addButtonTapped?()
        }

        addNotifyButton.addAction(addNotifyAction, for: .touchUpInside)

        addNotifyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(42)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }

    private func setUpNotificationTableView() {
        notificationContentView.addSubview(notificationTableView)

        notificationTableView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(42)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(addNotifyButton.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    private func setUpHintLabel() {
        notificationContentView.addSubview(hintLabel)
        hintLabel.text = "Вы пока не добавляли напоминаний"
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont.boldSystemFont(ofSize: 24)
        hintLabel.textColor = .lightGray
        hintLabel.isHidden = true
        hintLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
        }
    }

    func showHint() {
        hintLabel.isHidden = false
        notificationTableView.isHidden = true
    }

    func hideHint() {
        hintLabel.isHidden = true
        notificationTableView.isHidden = false
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = notificationContentView.frame.maxY
            initialTransform = notificationContentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 780 && newMaxY >= 570 {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                notificationContentView.transform = newTransform
            }
        }
    }

}
