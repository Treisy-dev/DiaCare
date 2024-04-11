//
//  ProductConfigView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.04.2024.
//

import SnapKit
import UIKit

final class ProductConfigView: UIView {

    private lazy var gradientView: CustomGradientView = CustomGradientView()
    private lazy var configImageView: UIImageView = UIImageView()
    private lazy var productConfigContentView: UIView = UIView()
    private lazy var titleLable: UILabel = UILabel()
    private lazy var defaultProfuctStatsLabel: UILabel = UILabel()
    private lazy var defaultProfuctStatsHStack: UIStackView = UIStackView()
    private lazy var grammsConfigLabel: UILabel = UILabel()
    private lazy var grammsConfigTextField: UITextField = UITextField()
    private lazy var grammsConfigSlider: UISlider = UISlider()
    private lazy var summaryLabel: UILabel = UILabel()
    private lazy var summaryHStack: UIStackView = UIStackView()
    private lazy var addButton: UIButton = UIButtonFabric.shared.makeAddButton()
    private lazy var closeButton: UIButton = UIButtonFabric.shared.makeCloseButton()

    var closeAction: (() -> Void)?
    var addAction: ((_ userProduct: UserProductModel) -> Void)?

    private lazy var productProps: (fat: String, protein: String, carbs: String) = ("", "", "")
    private var userBreadCount: Double = 10

    init(frame: CGRect, productName: String, productProps: (String, String, String), userBreadCount: String) {
        super.init(frame: frame)
        self.productProps = productProps
        backgroundColor = .white
        setUp()
        titleLable.text = productName
        guard let userBreadCount = Double(userBreadCount) else { return }
        self.userBreadCount = userBreadCount
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpGradientView()
        setUpDoctorImageView()
        setUpProfileContentView()
        setUpTitleLable()
        setUpDefaultProfuctStatsLabel()
        setUpDefaultProfuctStatsHStack()
        setUpGrammsConfigLabel()
        setUpGrammsConfigTextField()
        setUpGrammsConfigSlider()
        setUpSummaryLabel()
        setUpSummaryHStack()
        setUpAddButton()
        setUpCloseButton()
    }

    private func setUpGradientView() {
        addSubview(gradientView)
        gradientView.backgroundColor = .clear

        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }

    private func setUpDoctorImageView() {
        gradientView.addSubview(configImageView)
        configImageView.image = UIImage.productConfig
        configImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    private func setUpProfileContentView() {
        addSubview(productConfigContentView)
        productConfigContentView.layer.cornerRadius = 40
        productConfigContentView.backgroundColor = .white
        productConfigContentView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(250)
        }
    }

    private func setUpTitleLable() {
        productConfigContentView.addSubview(titleLable)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        titleLable.textAlignment = .center
        titleLable.textColor = .black

        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpDefaultProfuctStatsLabel() {
        productConfigContentView.addSubview(defaultProfuctStatsLabel)
        defaultProfuctStatsLabel.text = "В 100 гр. продукта:"
        defaultProfuctStatsLabel.font = UIFont.systemFont(ofSize: 16)
        defaultProfuctStatsLabel.textAlignment = .center
        defaultProfuctStatsLabel.textColor = .black

        defaultProfuctStatsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpDefaultProfuctStatsHStack() {
        productConfigContentView.addSubview(defaultProfuctStatsHStack)
        defaultProfuctStatsHStack.axis = .horizontal
        defaultProfuctStatsHStack.alignment = .center
        defaultProfuctStatsHStack.distribution = .equalSpacing
        defaultProfuctStatsHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Белки",
                titleLabelColor: .systemYellow,
                count: productProps.protein
            )
        )
        defaultProfuctStatsHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Жиры",
                titleLabelColor: .systemBlue,
                count: productProps.fat
            )
        )
        defaultProfuctStatsHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Углеводы",
                titleLabelColor: .systemRed,
                count: productProps.carbs
            )
        )

        defaultProfuctStatsHStack.snp.makeConstraints { make in
            make.top.equalTo(defaultProfuctStatsLabel.snp.bottom).offset(15)
            make.height.equalTo(70)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().inset(80)
        }
    }

    private func setUpGrammsConfigLabel() {
        productConfigContentView.addSubview(grammsConfigLabel)
        grammsConfigLabel.text = "Введите количество грамм"

        grammsConfigLabel.font = UIFont.boldSystemFont(ofSize: 24)
        grammsConfigLabel.textAlignment = .center
        grammsConfigLabel.textColor = .black

        grammsConfigLabel.snp.makeConstraints { make in
            make.top.equalTo(defaultProfuctStatsHStack.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpGrammsConfigTextField() {
        productConfigContentView.addSubview(grammsConfigTextField)
        grammsConfigTextField.textAlignment = .center
        grammsConfigTextField.layer.cornerRadius = 10
        grammsConfigTextField.layer.borderColor = UIColor.black.cgColor
        grammsConfigTextField.layer.borderWidth = 2
        grammsConfigTextField.font = UIFont.boldSystemFont(ofSize: 16)
        grammsConfigTextField.text = "100"

        let changeAction = UIAction { [weak self] _ in
            if let text = self?.grammsConfigTextField.text, let value = Float(text) {
                self?.grammsConfigSlider.value = value
                self?.changeSummaryProps()
            }
        }
        grammsConfigTextField.addAction(changeAction, for: .editingChanged)

        grammsConfigTextField.snp.makeConstraints { make in
            make.top.equalTo(grammsConfigLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
        }
    }

    private func setUpGrammsConfigSlider() {
        productConfigContentView.addSubview(grammsConfigSlider)
        grammsConfigSlider.minimumTrackTintColor = .black
        grammsConfigSlider.maximumValue = 300
        grammsConfigSlider.minimumValue = 0
        grammsConfigSlider.maximumTrackTintColor = .black
        grammsConfigSlider.thumbTintColor = .black
        grammsConfigSlider.value = 100

        grammsConfigSlider.setThumbImage(UIImage.blackSliderThumbIcon.resizeImage(newSize: CGSize(width: 15, height: 15)), for: .normal)
        let changeValueAction = UIAction { [weak self] _ in
            guard let value = self?.grammsConfigSlider.value else { return }
            self?.grammsConfigTextField.text = String(describing: round(value * 10) / 10)
            self?.changeSummaryProps()
        }

        grammsConfigSlider.addAction(changeValueAction, for: .valueChanged)
        grammsConfigSlider.snp.makeConstraints { make in
            make.top.equalTo(grammsConfigTextField.snp_bottomMargin).offset(25)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpSummaryLabel() {
        productConfigContentView.addSubview(summaryLabel)
        summaryLabel.text = "Итого:"

        summaryLabel.font = UIFont.boldSystemFont(ofSize: 24)
        summaryLabel.textAlignment = .center
        summaryLabel.textColor = .black

        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(grammsConfigSlider.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpSummaryHStack() {
        productConfigContentView.addSubview(summaryHStack)
        summaryHStack.axis = .horizontal
        summaryHStack.alignment = .center
        summaryHStack.distribution = .equalSpacing

        guard let proteinCount = Double(productProps.protein),
            let fatCount = Double(productProps.fat),
            let carbCount = Double(productProps.carbs),
            let gramms = grammsConfigTextField.text,
            let grammsDouble = Double(gramms) else { return }

        summaryHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Белки",
                titleLabelColor: .systemYellow,
                count: String(format: "%.1f", proteinCount / 100 * grammsDouble)
            )
        )
        summaryHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Жиры",
                titleLabelColor: .systemBlue,
                count: String(format: "%.1f", fatCount / 100 * grammsDouble)
            )
        )
        summaryHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "Углеводы",
                titleLabelColor: .systemRed,
                count: String(format: "%.1f", carbCount / 100 * grammsDouble)
            )
        )

        summaryHStack.addArrangedSubview(
            ProductVStackFabric.shared.makeCircledProductPropVStack(
                titleLabel: "ХЕ",
                titleLabelColor: .systemGreen,
                count: String(format: "%.1f", carbCount / userBreadCount)
            )
        )

        summaryHStack.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(30)
            make.height.equalTo(70)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
        }
    }

    private func setUpAddButton() {
        productConfigContentView.addSubview(addButton)
        let addAction: UIAction = UIAction { [weak self] _ in
            guard let userProduct = self?.getCofigedProductInfo() else { return }
            self?.addButton.addAlphaAnimation()
            self?.addAction?(userProduct)
        }
        addButton.addAction(addAction, for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(summaryHStack.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }

    private func setUpCloseButton() {
        productConfigContentView.addSubview(closeButton)
        let closeAction: UIAction = UIAction { [weak self] _ in
            self?.closeButton.addAlphaAnimation()
            self?.closeAction?()
        }
        closeButton.addAction(closeAction, for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(summaryHStack.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }

    private func changeSummaryProps() {
        guard let gramms = grammsConfigTextField.text,
            let grammsDouble = Double(gramms) else { return }
        changeSummaryProteinLabel(gramms: grammsDouble)
        changeSummaryFatLabel(gramms: grammsDouble)
        changeSummaryCarbsLabel(gramms: grammsDouble)
        changeSummaryBreadCountLabel(gramms: grammsDouble)
    }

    private func changeSummaryProteinLabel(gramms: Double) {
        guard let proteinItem = summaryHStack.arrangedSubviews[0] as? UIStackView,
            let proteinView = proteinItem.arrangedSubviews[1] as? CustomCircledView,
            let proteinCount = Double(productProps.protein) else { return }
        proteinView.countLabel.text = String(format: "%.1f", proteinCount / 100 * gramms)
    }

    private func changeSummaryFatLabel(gramms: Double) {
        guard let fatItem = summaryHStack.arrangedSubviews[1] as? UIStackView,
            let fatView = fatItem.arrangedSubviews[1] as? CustomCircledView,
            let fatCount = Double(productProps.fat) else { return }
        fatView.countLabel.text = String(format: "%.1f", fatCount / 100 * gramms)
    }

    private func changeSummaryCarbsLabel(gramms: Double) {
        guard let carbItem = summaryHStack.arrangedSubviews[2] as? UIStackView,
            let carbView = carbItem.arrangedSubviews[1] as? CustomCircledView,
            let carbCount = Double(productProps.carbs) else { return }
        carbView.countLabel.text = String(format: "%.1f", carbCount / 100 * gramms)
    }

    private func changeSummaryBreadCountLabel(gramms: Double) {
        guard let breadCountItem = summaryHStack.arrangedSubviews[3] as? UIStackView,
            let breadCountView = breadCountItem.arrangedSubviews[1] as? CustomCircledView,
            let carbCount = Double(productProps.carbs) else { return }
        breadCountView.countLabel.text = String(format: "%.1f", carbCount / 100 * gramms / userBreadCount)
    }

    private func getCofigedProductInfo() -> UserProductModel {
        guard let name = titleLable.text,
            let gramms = grammsConfigTextField.text,
            let protein = Double(productProps.protein),
            let fat = Double(productProps.fat),
            let carbs = Double(productProps.carbs),
            let grammsDouble = Double(gramms) else { return UserProductModel(
                name: "",
                protein: "",
                fat: "",
                carbs: "",
                breadCount: ""
            )
        }

        return UserProductModel(
            name: name,
            protein: String(format: "%.1f", protein / 100 * grammsDouble),
            fat: String(format: "%.1f", fat / 100 * grammsDouble),
            carbs: String(format: "%.1f", carbs / 100 * grammsDouble),
            breadCount: String(format: "%.1f", carbs / 100 * grammsDouble / userBreadCount)
        )
    }
}
