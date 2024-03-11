//
//  ProfileViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    private let contentView: ProfileView

    private let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        contentView = ProfileView(frame: CGRect(), userNameData: viewModel.userInfoData)
        super.init(nibName: nil, bundle: nil)
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
