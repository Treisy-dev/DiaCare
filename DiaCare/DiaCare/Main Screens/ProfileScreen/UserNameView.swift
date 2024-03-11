//
//  UserNameView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

class UserNameSubView: UIView {

    lazy var profileVStack: UIStackView = UIStackView()
    lazy var profileLable: UILabel = UILabel()
    lazy var nameHStack: UIStackView = UIStackView()
    lazy var nameLable: UILabel = UILabel()
    lazy var nameIconImageView: UIImageView = UIImageView()
    lazy var emailHStack: UIStackView = UIStackView()
    lazy var emailLabel: UILabel = UILabel()
    lazy var emailIconImageView: UIImageView = UIImageView()
    lazy var underlineView: CustomUnderlineView = CustomUnderlineView(frame: CGRect(x: 0, y: 0, width: 200, height: 1))

    init(frame: CGRect, name: String, email: String) {
        super.init(frame: frame)
        setUp()
        nameLable.text = name
        emailLabel.text = email
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpProfileVStack()
    }

    private func setUpNameHStack() {
        nameHStack.axis = .horizontal
        nameHStack.spacing = 15

        nameIconImageView.image = UIImage.personIcon
        nameIconImageView.contentMode = .center
        nameIconImageView.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        nameHStack.addArrangedSubview(nameIconImageView)

        nameLable.font = UIFont.systemFont(ofSize: 16)
        nameLable.textColor = .black
        nameLable.minimumScaleFactor = 0.5
        nameLable.adjustsFontSizeToFitWidth = true
        nameLable.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(160)
        }
        nameHStack.addArrangedSubview(nameLable)
    }

    private func setUpEmailHStack() {
        emailHStack.axis = .horizontal
        emailHStack.spacing = 15
        emailHStack.distribution = .equalSpacing
        emailIconImageView.image = UIImage.emailIcon
        emailIconImageView.contentMode = .center
        emailIconImageView.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        emailHStack.addArrangedSubview(emailIconImageView)

        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textColor = .black
        emailLabel.minimumScaleFactor = 0.5
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(160)
        }
        emailHStack.addArrangedSubview(emailLabel)
    }

    private func setUpProfileVStack() {
        setUpNameHStack()
        setUpEmailHStack()
        addSubview(profileVStack)
        profileLable.text = "Профиль:"
        profileLable.font = UIFont.systemFont(ofSize: 16)
        profileLable.textColor = .black
        profileVStack.axis = .vertical
        profileVStack.distribution = .fillEqually
        profileVStack.spacing = 15
        profileVStack.addArrangedSubview(profileLable)
        profileVStack.addArrangedSubview(nameHStack)
        profileVStack.addArrangedSubview(emailHStack)
        profileVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(profileVStack.snp_bottomMargin).offset(25)
            make.leading.equalTo(profileVStack.snp_leadingMargin)
        }
    }
}
