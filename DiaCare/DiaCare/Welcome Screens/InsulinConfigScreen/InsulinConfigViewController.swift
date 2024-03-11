//
//  InsulinConfigViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 10.03.2024.
//

import UIKit

class InsulinConfigViewController: UIViewController {

    private let contentView: InsulinConfigView = .init()

    private let viewModel: InsulinConfigViewModel

    init(viewModel: InsulinConfigViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        contentView.shortPickerView.delegate = self
        contentView.shortPickerView.dataSource = viewModel
        contentView.longPickerView.delegate = self
        contentView.longPickerView.dataSource = viewModel
    }
}

extension InsulinConfigViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == contentView.shortPickerView {
            contentView.shortInsulinField.text = viewModel.shortDataSource[row]
        } else {
            contentView.longInsulinField.text = viewModel.longDataSource[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == contentView.shortPickerView {
            viewModel.shortDataSource[row]
        } else {
            viewModel.longDataSource[row]
        }
    }
}

extension InsulinConfigViewController: InsulinConfigViewDelegate {
    func didPressSave(shortInsulin: String?, longInsulin: String?) {
        viewModel.saveUserInfo(shortInsulin: shortInsulin, longInsulin: longInsulin)
        showMainScreen()
    }

    func showMainScreen() {
        let tbController: UITabBarController = UITabBarController()
        tbController.tabBar.tintColor = .mainApp

        let templateViewController = TemplateViewController()
        let templateTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.listIcon,
            selectedImage: nil)
        templateViewController.tabBarItem = templateTabBarItem

        let statisticViewController = StatisticViewController()
        let statisticTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.chartIcon,
            selectedImage: nil)
        statisticViewController.tabBarItem = statisticTabBarItem

        let newNoteViewController = NewNoteViewController()
        let newNoteTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.plusIcon,
            selectedImage: nil)
        newNoteViewController.tabBarItem = newNoteTabBarItem

        let notificationViewController = NotificationViewController()
        let notificationTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.bellIcon,
            selectedImage: nil)
        notificationViewController.tabBarItem = notificationTabBarItem

        let profileViewController = ProfileViewController(viewModel: ProfileViewModel())
        let profileTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage.profileIcon,
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        tbController.viewControllers = [
            UINavigationController(rootViewController: templateViewController),
            UINavigationController(rootViewController: statisticViewController),
            UINavigationController(rootViewController: newNoteViewController),
            UINavigationController(rootViewController: notificationViewController),
            UINavigationController(rootViewController: profileViewController)
            ]
        tbController.selectedIndex = 4

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tbController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
