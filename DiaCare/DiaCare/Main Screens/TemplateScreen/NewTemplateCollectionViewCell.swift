//
//  NewTemplateCollectionViewCell.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 14.05.2024.
//
import SnapKit
import UIKit

final class NewTemplateCollectionViewCell: UICollectionViewCell {

    private lazy var newTemplateLabel: UILabel = UILabel()
    private lazy var newTemplateImage: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpNewTemplateLabel()
        setUpNewTemplateImage()
    }

    private func setUpNewTemplateLabel() {
        addSubview(newTemplateLabel)
        newTemplateLabel.textColor = .systemGray
        newTemplateLabel.text = "Добавить комбинацию"
        newTemplateLabel.textAlignment = .center
        newTemplateLabel.numberOfLines = 2
        newTemplateLabel.font = UIFont.systemFont(ofSize: 16)
        newTemplateLabel.lineBreakMode = .byWordWrapping
        newTemplateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(105)
        }
    }

    private func setUpNewTemplateImage() {
        addSubview(newTemplateImage)
        newTemplateImage.image = .newTemplateIcon
        newTemplateImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newTemplateLabel.snp.bottom).offset(15)
            make.width.height.equalTo(45)
        }
    }
}
