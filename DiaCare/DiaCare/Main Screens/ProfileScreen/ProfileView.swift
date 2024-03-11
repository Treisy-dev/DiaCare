//
//  ProfileView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

class ProfileView: UIView {

    private var userNameSubView: UserNameSubView?
    private var preferencesSubView: PreferencesSubView?
    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var profileContentView: UIView = UIView()
    private lazy var doctorImageView: UIImageView = UIImageView()

    init(frame: CGRect, userNameData: [String: String]) {
        super.init(frame: frame)
        userNameSubView = UserNameSubView(
            frame: frame,
            name: prepareData(with: userNameData, for: "name"),
            email: prepareData(with: userNameData, for: "email"))
        preferencesSubView = PreferencesSubView(
            frame: frame,
            targetSugarText: prepareData(with: userNameData, for: "targetSugar") + " ммоль/л",
            highSugarText: prepareData(with: userNameData, for: "hightSugar") + " ммоль/л",
            lowSugarText: prepareData(with: userNameData, for: "lowSugar") + " ммоль/л")
        backgroundColor = .white
        setUp()
    }

    private func prepareData(with userNameData: [String: String], for key: String) -> String {
        guard let arg = userNameData[key] else { return ""}
        return arg
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpGradientView()
        setUpTitleLable()
        setUpProfileContentView()
        setUpDoctorImageView()
        setUpUserNameSubView()
        setUpPreferencesSubView()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }

    private func setUpProfileContentView() {
        addSubview(profileContentView)
        profileContentView.layer.cornerRadius = 40
        profileContentView.backgroundColor = .white
        profileContentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(165)
            make.height.equalTo(400)
        }
    }

    private func setUpTitleLable() {
        addSubview(titleLable)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textColor = .white
        titleLable.text = "Профиль"

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.leading.equalToSuperview().offset(50)
        }
    }

    private func setUpDoctorImageView() {
        profileContentView.addSubview(doctorImageView)
        doctorImageView.image = UIImage.doctor
        doctorImageView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(33)
            make.top.equalTo(self.snp_topMargin).inset(-50)
            make.width.equalTo(155)
            make.height.equalTo(310)
        }
    }

    private func setUpUserNameSubView() {
        profileContentView.addSubview(userNameSubView ?? UIView())
        userNameSubView?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(50)
            make.width.lessThanOrEqualTo(200)
        }
    }

    private func setUpPreferencesSubView() {
        profileContentView.addSubview(preferencesSubView ?? UIView())
        preferencesSubView?.snp.makeConstraints { make in
            make.top.equalTo(userNameSubView!.snp_bottomMargin).offset(50)
            make.leading.equalToSuperview().offset(50)
            make.trailing.lessThanOrEqualToSuperview().offset(50)
        }
    }
}
