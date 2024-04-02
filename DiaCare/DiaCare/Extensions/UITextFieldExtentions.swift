//
//  UITextFieldExtentions.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 01.04.2024.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification)
            .compactMap({$0.object as? UITextField})
            .map({$0.text ?? ""})
            .eraseToAnyPublisher()
    }
}
