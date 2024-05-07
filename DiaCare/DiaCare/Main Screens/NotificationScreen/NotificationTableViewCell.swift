//
//  NotificationTableViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.05.2024.
//
import SnapKit
import UIKit

final class NotificationTableViewCell: UITableViewCell {

    private lazy var cellView: UIView = UIView()
    private lazy var notificationIcon: UIImageView = UIImageView()
    private lazy var notificationTitle: UILabel = UILabel()
    private lazy var separator: UIView = UIView()
    private lazy var watchIcon: UIImageView = UIImageView()
    private lazy var timeStackView: UIStackView = UIStackView()
    private lazy var dateTitle: UILabel = UILabel()
    private lazy var timeTitle: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpCellView()
        setUpNotificationIcon()
        setUpNotificationTitle()
        setUpSeparator()
        setUpWatchIcon()
        setUpTimeStackView()
        setUpDateTitle()
        setUpTimeTitle()
    }

    func config(isColored: Bool, title: String, date: String, time: String) {
        notificationTitle.text = title
        dateTitle.text = date
        timeTitle.text = time
        if isColored {
            makeCellColored()
        } else {
            makeCellUncolored()
        }
    }

    private func setUpCellView() {
        addSubview(cellView)
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(2)
            make.trailing.bottom.equalToSuperview().inset(2)
        }
    }

    private func setUpNotificationIcon() {
        cellView.addSubview(notificationIcon)
        notificationIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(19)
            make.height.equalTo(22)
        }
    }

    private func setUpNotificationTitle() {
        cellView.addSubview(notificationTitle)
        notificationTitle.textAlignment = .center
        notificationTitle.font = UIFont.systemFont(ofSize: 16)
        notificationTitle.snp.makeConstraints { make in
            make.leading.equalTo(notificationIcon.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(140)
        }
    }

    private func setUpSeparator() {
        cellView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().inset(2)
            make.leading.equalTo(notificationTitle.snp.trailing).offset(20)
            make.width.equalTo(1)
        }
    }

    private func setUpWatchIcon() {
        cellView.addSubview(watchIcon)
        watchIcon.snp.makeConstraints { make in
            make.leading.equalTo(separator.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18)
        }
    }

    private func setUpTimeStackView() {
        cellView.addSubview(timeStackView)
        timeStackView.alignment = .center
        timeStackView.distribution = .equalSpacing
        timeStackView.axis = .vertical

        timeStackView.snp.makeConstraints { make in
            make.leading.equalTo(watchIcon.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().inset(7)
        }
    }

    private func setUpDateTitle() {
        timeStackView.addArrangedSubview(dateTitle)
        dateTitle.textAlignment = .center
        dateTitle.font = UIFont.systemFont(ofSize: 10)
    }

    private func setUpTimeTitle() {
        timeStackView.addArrangedSubview(timeTitle)
        timeTitle.textAlignment = .center
        timeTitle.font = UIFont.systemFont(ofSize: 10)
    }

    private func makeCellColored() {
        notificationIcon.image = UIImage.notificationIconColored
        notificationTitle.textColor = .mainApp
        separator.backgroundColor = .mainApp
        watchIcon.image = UIImage.watchIconColored
        dateTitle.textColor = .mainApp
        timeTitle.textColor = .mainApp
        cellView.layer.borderColor = UIColor.mainApp.cgColor
    }

    private func makeCellUncolored() {
        notificationIcon.image = UIImage.notificationIcon
        notificationTitle.textColor = .lightGray
        separator.backgroundColor = .lightGray
        watchIcon.image = UIImage.watchIcon
        dateTitle.textColor = .lightGray
        timeTitle.textColor = .lightGray
        cellView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
