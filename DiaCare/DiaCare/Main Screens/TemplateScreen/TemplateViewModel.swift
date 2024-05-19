//
//  TemplateViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

protocol TemplateViewModelProtocol: UICollectionViewDataSource {
    var dataSource: [Templates] { get }
}

final class TemplateViewModel: NSObject, TemplateViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol
    var dataSource: [Templates] = []

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationReceived),
            name: Notification.Name("updateTemplateNotification"),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("updateTemplateNotification"), object: nil)
    }

    @objc func notificationReceived(_ notification: Notification) {
        updateDataSource()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == dataSource.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewTemplateCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
                as? NewTemplateCollectionViewCell else { return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TemplateCollectionViewCell.reuseIdentifier,
                for: indexPath
            )
                as? TemplateCollectionViewCell else { return UICollectionViewCell()}
            guard let productsArray = dataSource[indexPath.row].templateProduct?.allObjects as? [TemplateProduct]
            else { return UICollectionViewCell()}

            let category = getCategoryFromString(dataSource[indexPath.row].category)
            cell.config(
                templateTitle: dataSource[indexPath.row].name,
                templateCategory: category,
                products: productsArray,
                stats: (dataSource[indexPath.row].breadCount, dataSource[indexPath.row].insulin)
            )

            return cell
        }
    }

    private func updateDataSource() {
        dataSource = coreDataManager.obtainUsersTemplates()
    }

    private func getCategoryFromString(_ categoryString: String) -> TemplateCategories {
        if let category = TemplateCategories(rawValue: categoryString) {
            return category
        } else {
            return .none
        }
    }
}
