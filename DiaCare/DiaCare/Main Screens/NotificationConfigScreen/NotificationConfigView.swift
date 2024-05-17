//
//  NotificationConfigView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 04.05.2024.
//
import SnapKit
import UIKit

final class NotificationConfigView: UIView {
    lazy var titleTextField: UITextField = UITextField()
    lazy var datePicker: UIDatePicker = UIDatePicker()
    lazy var messageTextField: UITextField = UITextField()
    var addButtonTapped: (() -> Void)?
    var backButtonTapped: (() -> Void)?

    private lazy var configTitle: UILabel = UILabel()
    private lazy var backButton: UIButton = UIButton()
    private lazy var titleView: UIView = UIView()
    private lazy var bellIcon: UIImageView = UIImageView()
    private lazy var titleSeparator: UIView = UIView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var dateView: UIView = UIView()
    private lazy var dateIcon: UIImageView = UIImageView()
    private lazy var dateSeparator: UIView = UIView()
    private lazy var dateLabel: UILabel = UILabel()
    private lazy var messageView: UIView = UIView()
    private lazy var messageTitle: UILabel = UILabel()
    private lazy var addButton: UIButton = UIButton()
    private lazy var configImage: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpConfigTitle()
        setUpBackButton()
        setUpTitleView()
        setUpBellIcon()
        setUpSeparator()
        setUpTitleLabel()
        setUpTitleTextField()
        setUpDateView()
        setUpDateIcon()
        setUpDateSeparator()
        setUpDateLabel()
        setUpDatePicker()
        setUpMessageView()
        setUpMessageTitle()
        setUpMessageTextField()
        setUpAddButton()
        setUpConfigImage()
    }

    private func setUpConfigTitle() {
        addSubview(configTitle)
        configTitle.text = "Добавление напоминания"
        configTitle.numberOfLines = 2
        configTitle.textAlignment = .center
        configTitle.textColor = .black
        configTitle.font = UIFont.boldSystemFont(ofSize: 24)

        configTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.width.equalTo(215)
        }
    }

    private func setUpBackButton() {
        addSubview(backButton)
        let backAction: UIAction = UIAction { [weak self] _ in
            self?.backButtonTapped?()
        }
        backButton.addAction(backAction, for: .touchUpInside)
        backButton.setImage(UIImage.backIcon, for: .normal)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(47)
            make.height.equalTo(16)
            make.width.equalTo(18)
            make.top.equalToSuperview().offset(90)
        }
    }

    private func setUpTitleView() {
        addSubview(titleView)
        titleView.layer.cornerRadius = 20
        titleView.layer.borderWidth = 1
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(62)
            make.top.equalTo(configTitle.snp.bottom).offset(30)
        }
    }

    private func setUpBellIcon() {
        titleView.addSubview(bellIcon)
        bellIcon.image = UIImage.notificationIconColored
        bellIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(27)
            make.width.equalTo(25)
        }
    }

    private func setUpSeparator() {
        titleView.addSubview(titleSeparator)
        titleSeparator.backgroundColor = .lightGray
        titleSeparator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalTo(bellIcon.snp.trailing).offset(10)
            make.width.equalTo(1)
        }
    }

    private func setUpTitleLabel() {
        titleView.addSubview(titleLabel)
        titleLabel.text = "Название напоминания"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleSeparator.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(35)
        }
    }

    private func setUpTitleTextField() {
        titleView.addSubview(titleTextField)
        titleTextField.textAlignment = .center
        titleTextField.textColor = .black
        titleTextField.placeholder = "Введите название"
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleSeparator.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(35)
        }
    }

    private func setUpDateView() {
        addSubview(dateView)
        dateView.layer.cornerRadius = 20
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.lightGray.cgColor
        dateView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(75)
            make.top.equalTo(titleView.snp.bottom).offset(20)
        }
    }

    private func setUpDateIcon() {
        dateView.addSubview(dateIcon)
        dateIcon.image = UIImage.dateIcon
        dateIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(27)
            make.width.equalTo(25)
        }
    }

    private func setUpDateSeparator() {
        dateView.addSubview(dateSeparator)
        dateSeparator.backgroundColor = .lightGray
        dateSeparator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalTo(dateIcon.snp.trailing).offset(10)
            make.width.equalTo(1)
        }
    }

    private func setUpDateLabel() {
        dateView.addSubview(dateLabel)
        dateLabel.text = "Выберите дату и время"
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .center
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateSeparator.snp.trailing)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setUpDatePicker() {
        dateView.addSubview(datePicker)
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .mainApp
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.centerX.equalTo(dateLabel.snp.centerX)
        }
    }

    private func setUpMessageView() {
        addSubview(messageView)
        messageView.layer.cornerRadius = 20
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(70)
            make.top.equalTo(dateView.snp.bottom).offset(20)
        }
    }

    private func setUpMessageTitle() {
        messageView.addSubview(messageTitle)
        messageTitle.text = "Текст напоминания"
        messageTitle.font = UIFont.systemFont(ofSize: 16)
        messageTitle.textColor = .lightGray
        messageTitle.textAlignment = .center
        messageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
    }

    private func setUpMessageTextField() {
        messageView.addSubview(messageTextField)
        messageTextField.placeholder = "Введите текст напоминание"
        messageTextField.textAlignment = .center
        messageTextField.textColor = .black
        messageTextField.adjustsFontSizeToFitWidth = true
        messageTextField.minimumFontSize = 12.0
        messageTextField.snp.makeConstraints { make in
            make.top.equalTo(messageTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setUpAddButton() {
        addSubview(addButton)
        addButton.backgroundColor = .mainApp
        addButton.layer.cornerRadius = 23
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        let addNotifyAction: UIAction = UIAction { [weak self] _ in
            self?.addButtonTapped?()
        }
        addButton.addAction(addNotifyAction, for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(140)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpConfigImage() {
        addSubview(configImage)
        configImage.image = UIImage.notificationConfig
        configImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().inset(7)
            make.height.equalTo(270)
        }
    }
}
