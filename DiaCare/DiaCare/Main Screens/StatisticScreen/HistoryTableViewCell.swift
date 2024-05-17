//
//  HistoryTableViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 06.05.2024.
//
import SnapKit
import UIKit

final class HistoryTableViewCell: UITableViewCell {
    private lazy var cellView: UIView = UIView()
    private lazy var timeLabel: UILabel = UILabel()
    private lazy var dateLabel: UILabel = UILabel()
    private lazy var bloodIcon: UIImageView = UIImageView()
    private lazy var bloodCount: UILabel = UILabel()
    private lazy var breadIcon: UIImageView = UIImageView()
    private lazy var breadCount: UILabel = UILabel()
    private lazy var insulinIcon: UIImageView = UIImageView()
    private lazy var insulinCount: UILabel = UILabel()
    private lazy var longInsulinIcon: UIImageView = UIImageView()
    private lazy var longInsulinCount: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(
        date: (date: String, time: String),
        bloodCount: String,
        breadCount: String,
        insulinCount: String,
        longInsulinCount: String
    ) {
        timeLabel.text = date.time
        dateLabel.text = date.date
        self.bloodCount.text = bloodCount
        if Double(breadCount) == 0 {
            breadIcon.image = .breadIcon
            self.breadCount.text = "-"
        } else {
            breadIcon.image = .breadIconFill
            self.breadCount.text = breadCount
        }
        if Double(insulinCount) == 0 {
            insulinIcon.image = .shortInsulinIcon
            self.insulinCount.text = "-"
        } else {
            insulinIcon.image = .longInsulinIcon
            self.insulinCount.text = insulinCount
        }
        if Double(longInsulinCount) == 0 {
            longInsulinIcon.image = .insulinGreen
            self.longInsulinCount.text = "-"
        } else {
            longInsulinIcon.image = .insulinGreenFill
            self.longInsulinCount.text = longInsulinCount
        }
    }

    private func setUp() {
        setUpCellView()
        setUpTimeLabel()
        setUpDateLabel()
        setUpBloodIcon()
        setUpBloodCount()
        setUpBreadIcon()
        setUpBreadCount()
        setUpInsulinIcon()
        setUpInsulinCount()
        setUpLongInsulinIcon()
        setUpLongInsulinCount()
    }

    private func setUpCellView() {
        addSubview(cellView)
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 12
        cellView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().inset(3)
        }
    }

    private func setUpTimeLabel() {
        cellView.addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .lightGray
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(10)
        }
    }

    private func setUpDateLabel() {
        cellView.addSubview(dateLabel)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    private func setUpBloodIcon() {
        cellView.addSubview(bloodIcon)
        bloodIcon.image = .bloodFillIcon
        bloodIcon.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(17)
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(timeLabel.snp.bottom).offset(11)
        }
    }

    private func setUpBloodCount() {
        cellView.addSubview(bloodCount)
        bloodCount.font = UIFont.systemFont(ofSize: 16)
        bloodCount.textColor = .black
        bloodCount.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.equalTo(bloodIcon.snp.trailing).offset(10)
        }
    }

    private func setUpBreadIcon() {
        cellView.addSubview(breadIcon)
        breadIcon.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(17)
            make.top.equalTo(timeLabel.snp.bottom).offset(11)
            make.leading.equalTo(bloodCount.snp.trailing).offset(25)
        }
    }

    private func setUpBreadCount() {
        cellView.addSubview(breadCount)
        breadCount.font = UIFont.systemFont(ofSize: 16)
        breadCount.textColor = .black
        breadCount.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.equalTo(breadIcon.snp.trailing).offset(10)
        }
    }

    private func setUpInsulinIcon() {
        cellView.addSubview(insulinIcon)
        insulinIcon.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.top.equalTo(timeLabel.snp.bottom).offset(11)
            make.leading.equalTo(breadCount.snp.trailing).offset(25)
        }
    }

    private func setUpInsulinCount() {
        cellView.addSubview(insulinCount)
        insulinCount.font = UIFont.systemFont(ofSize: 16)
        insulinCount.textColor = .black
        insulinCount.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.equalTo(insulinIcon.snp.trailing).offset(10)
        }
    }

    private func setUpLongInsulinIcon() {
        cellView.addSubview(longInsulinIcon)
        longInsulinIcon.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.top.equalTo(timeLabel.snp.bottom).offset(11)
            make.leading.equalTo(insulinCount.snp.trailing).offset(25)
        }
    }

    private func setUpLongInsulinCount() {
        cellView.addSubview(longInsulinCount)
        longInsulinCount.font = UIFont.systemFont(ofSize: 16)
        longInsulinCount.textColor = .black
        longInsulinCount.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.equalTo(longInsulinIcon.snp.trailing).offset(10)
        }
    }
}
