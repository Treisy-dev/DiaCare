//
//  NewNoteViewModel.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import Foundation

protocol NewNoteViewModelProtocol {
    var averageSugar: String { get }
    var coreDataManager: CoreDataManagerProtocol { get }
}

final class NewNoteViewModel: NewNoteViewModelProtocol {
    var averageSugar = "8.5"
    var coreDataManager: CoreDataManagerProtocol

    init(coreDM: CoreDataManagerProtocol) {
        coreDataManager = coreDM
    }
}
