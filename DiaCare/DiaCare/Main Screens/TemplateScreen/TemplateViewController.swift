//
//  TemplateViewController.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

final class TemplateViewController: UIViewController {

    private let contentView: TemplateView

    private let viewModel: TemplateViewModelProtocol

    var addNewTemplate: (() -> Void)?

    init(viewModel: TemplateViewModelProtocol) {
        self.viewModel = viewModel
        contentView = TemplateView(frame: CGRect())
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
        contentView.templatesCollectionView.delegate = self
        contentView.templatesCollectionView.dataSource = viewModel
        contentView.templatesCollectionView.register(
            TemplateCollectionViewCell.self,
            forCellWithReuseIdentifier: TemplateCollectionViewCell.reuseIdentifier)

        contentView.templatesCollectionView.register(
            NewTemplateCollectionViewCell.self,
            forCellWithReuseIdentifier: NewTemplateCollectionViewCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateDataSource()
        contentView.templatesCollectionView.reloadData()
    }
}

extension TemplateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width / 2 - 10
            let height = 153.0
            return CGSize(width: width, height: height)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is NewTemplateCollectionViewCell {
            addNewTemplate?()
        }
    }
}
