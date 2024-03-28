//
//  NewNoteView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

final class NewNoteView: UIView {

    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var newNoteContentView: UIView = UIView()
    private lazy var doctorImageView: UIImageView = UIImageView()
    private var averageSugar: String?
    private var sugarSubView: NewNoteSugarSubView
    var foodSubView: NewNoteFoodSubView = NewNoteFoodSubView(frame: CGRect())
    var injectionSubView: NewNoteInjectionSubView = NewNoteInjectionSubView(frame: CGRect())

    private lazy var resetButton: UIButton = UIButton()
    private lazy var saveButton: UIButton = UIButton()

    private var initialCenterYConstraintConstant: CGFloat = 0
    private var initialTransform = CGAffineTransform.identity
    private var panGestureRecognizer: UIPanGestureRecognizer?

    init(frame: CGRect, averageSugar: String) {
        sugarSubView = NewNoteSugarSubView(frame: frame, avarageSugar: averageSugar)
        super.init(frame: frame)
        self.averageSugar = averageSugar
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
            newNoteContentView.addGestureRecognizer(panGestureRecognizer)
        }
    }

    private func setUp() {
        setUpGradientView()
        setUpDoctorImageView()
        setUpTitleLable()
        setUpNewNoteContentView()
        setUpSugarSubView()
        setUpFoodSubView()
        setUpInjectionSubView()
        setUpResetButton()
        setUpSaveButton()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }

    private func setUpNewNoteContentView() {
        addSubview(newNoteContentView)
        newNoteContentView.layer.cornerRadius = 40
        newNoteContentView.backgroundColor = .white
        newNoteContentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(285)
            make.height.equalTo(800)
        }
    }

    private func setUpTitleLable() {
        newNoteContentView.addSubview(titleLable)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textColor = .black
        titleLable.text = "Добавление записи"

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpDoctorImageView() {
        addSubview(doctorImageView)
        doctorImageView.image = UIImage.newNote
        doctorImageView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.top.equalTo(self.snp_topMargin).inset(-45)
            make.height.equalTo(244)
        }
    }

    private func setUpSugarSubView() {
        newNoteContentView.addSubview(sugarSubView)
        sugarSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.trailing.equalToSuperview().inset(33)
            make.top.equalTo(titleLable.snp_bottomMargin).offset(20)
            make.height.equalTo(125)
        }
    }

    private func setUpFoodSubView() {
        newNoteContentView.addSubview(foodSubView)
        foodSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.trailing.equalToSuperview().inset(33)
            make.top.equalTo(sugarSubView.snp_bottomMargin).offset(20)
            make.height.equalTo(140)
        }
    }

    private func setUpInjectionSubView() {
        newNoteContentView.addSubview(injectionSubView)
        injectionSubView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.trailing.equalToSuperview().inset(33)
            make.top.equalTo(foodSubView.snp_bottomMargin).offset(20)
            make.height.equalTo(255)
        }
    }

    private func setUpResetButton() {
        newNoteContentView.addSubview(resetButton)
        resetButton.backgroundColor = .white
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.mainApp.cgColor
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.setTitleColor(.mainApp, for: .normal)
        let resetAction = UIAction { [weak self] _ in
            self?.injectionSubView.breadTextField.text = "0"
            self?.injectionSubView.insulinTextField.text = "0"
            self?.injectionSubView.breadSlider.value = 0
            self?.injectionSubView.insulinSlider.value = 0
            self?.sugarSubView.sugarCountLabel.text = self?.averageSugar
        }

        resetButton.addAction(resetAction, for: .touchUpInside)

        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.top.equalTo(injectionSubView.snp_bottomMargin).offset(40)
            make.width.equalTo(158)
            make.height.equalTo(40)
        }
    }

    private func setUpSaveButton() {
        newNoteContentView.addSubview(saveButton)
        saveButton.backgroundColor = .mainApp
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.mainApp.cgColor
        saveButton.setTitle("Добавить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)

        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(33)
            make.leading.equalTo(resetButton.snp.trailing).offset(11)
            make.top.equalTo(injectionSubView.snp_bottomMargin).offset(40)
            make.height.equalTo(40)
        }
    }

    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        if recognizer.state == .began {
            initialCenterYConstraintConstant = newNoteContentView.frame.maxY
            initialTransform = newNoteContentView.transform
        } else if recognizer.state == .changed {
            let newMaxY = initialCenterYConstraintConstant + translation.y

            if newMaxY <= 1085 && newMaxY >= 870 {
                let newTransform = initialTransform.translatedBy(x: 0, y: translation.y)
                newNoteContentView.transform = newTransform
            }
        }
    }
}
