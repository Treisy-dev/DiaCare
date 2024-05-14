//
//  TemplateView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

final class TemplateView: UIView {
    private lazy var templateLabel: UILabel = UILabel()
    private lazy var templateImage: UIImageView = UIImageView()
    lazy var templatesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white.withAlphaComponent(0.96)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTemplateLabel()
        setUpTemplateImage()
        setUpTemplatesCollectionView()
    }

    private func setUpTemplateLabel() {
        addSubview(templateLabel)
        templateLabel.font = UIFont.boldSystemFont(ofSize: 24)
        templateLabel.text = "Частые комбинации блюд"
        templateLabel.numberOfLines = 3
        templateLabel.lineBreakMode = .byWordWrapping
        templateLabel.textAlignment = .left

        templateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.leading.equalToSuperview().offset(44)
            make.width.equalTo(173)
        }
    }

    private func setUpTemplateImage() {
        addSubview(templateImage)
        templateImage.image = .templates
        templateImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(44)
            make.leading.equalTo(templateLabel.snp.trailing)
            make.top.equalToSuperview().offset(84)
            make.height.equalTo(127)
        }
    }

    private func setUpTemplatesCollectionView() {
        addSubview(templatesCollectionView)
        templatesCollectionView.backgroundColor = .clear
        templatesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(templateImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(37)
            make.trailing.equalToSuperview().inset(37)
            make.bottom.equalToSuperview()
        }
    }
}
