//
//  CoordinatorProtocol.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 03.04.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
