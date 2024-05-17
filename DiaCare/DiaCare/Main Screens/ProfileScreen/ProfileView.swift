//
//  ProfileView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

final class ProfileView: UIView {

    let userDefaultsDataManager: UserDefaultsDataManagerProtocol
    var settingsSubView: SettingsSubView
    private var userNameSubView: UserNameSubView
    private var preferencesSubView: PreferencesSubView
    private var dragSubView: DragSubView
    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var profileContentView: UIView = UIView()
    private lazy var doctorImageView: UIImageView = UIImageView()
    private var preferencesHStackFabric: PreferencesHStackFabricProtocol = PreferencesHStackFabric()

    private var initialCenterYConstraintConstant: CGFloat = 0
    private var panGestureRecognizer: UIPanGestureRecognizer?

    init(frame: CGRect, userNameData: [String: String], selectedLanguage: String, userDefaultsDM: UserDefaultsDataManagerProtocol) {
        userDefaultsDataManager = userDefaultsDM
        dragSubView = DragSubView(
            frame: frame,
            shortInsulin: userDefaultsDataManager.prepareData(with: userNameData, for: "shortInsulin"),
            longInsulin: userDefaultsDataManager.prepareData(with: userNameData, for: "longInsulin"),
            preferenceHStackFabric: preferencesHStackFabric)
        userNameSubView = UserNameSubView(
            frame: frame,
            name: userDefaultsDataManager.prepareData(with: userNameData, for: "name"),
            email: userDefaultsDataManager.prepareData(with: userNameData, for: "email"))
        preferencesSubView = PreferencesSubView(
            frame: frame,
            targetSugarText: userDefaultsDataManager.prepareData(with: userNameData, for: "targetSugar"),
            highSugarText: userDefaultsDataManager.prepareData(with: userNameData, for: "hightSugar"),
            lowSugarText: userDefaultsDataManager.prepareData(with: userNameData, for: "lowSugar"),
            foodText: userDefaultsDataManager.prepareData(with: userNameData, for: "breadCount"),
            insulinText: userDefaultsDataManager.prepareData(with: userNameData, for: "insulinCount"),
            preferenceHStackFabric: preferencesHStackFabric)
        settingsSubView = SettingsSubView(frame: frame, selectedLanguage: selectedLanguage)
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
            profileContentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    private func setUp() {
        setUpGradientView()
        setUpTitleLable()
        setUpProfileContentView()
        setUpDoctorImageView()
        setUpUserNameSubView()
        setUpPreferencesSubView()
        setUpDragSubView()
        setUpSettingsSubView()
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
            make.height.equalTo(800)
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
        profileContentView.addSubview(userNameSubView)
        userNameSubView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(50)
            make.width.lessThanOrEqualTo(200)
        }
    }

    private func setUpPreferencesSubView() {
        profileContentView.addSubview(preferencesSubView)
        preferencesSubView.snp.makeConstraints { make in
            make.top.equalTo(userNameSubView.snp.bottom).offset(35)
            make.trailing.greaterThanOrEqualToSuperview().inset(50)
            make.leading.lessThanOrEqualToSuperview().offset(50)
        }
    }

    private func setUpDragSubView() {
        profileContentView.addSubview(dragSubView)
        dragSubView.snp.makeConstraints { make in
            make.top.equalTo(preferencesSubView.snp.bottom).offset(35)
            make.trailing.greaterThanOrEqualToSuperview().inset(50)
            make.leading.lessThanOrEqualToSuperview().offset(50)
        }
    }

    private func setUpSettingsSubView() {
        profileContentView.addSubview(settingsSubView)
        settingsSubView.snp.makeConstraints { make in
            make.top.equalTo(dragSubView.snp.bottom).offset(35)
            make.trailing.greaterThanOrEqualToSuperview().inset(50)
            make.leading.lessThanOrEqualToSuperview().offset(50)
        }
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = profileContentView.frame.maxY
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y
            if newMaxY <= 965 && newMaxY >= 900 {
                profileContentView.center.y = newMaxY - profileContentView.frame.height / 2
            }
        }
    }
}
