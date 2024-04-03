//
//  TemplateViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import Foundation

protocol TemplateViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol { get }
}

final class TemplateViewModel: TemplateViewModelProtocol {
    var coreDataManager: CoreDataManagerProtocol

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
    }
}
