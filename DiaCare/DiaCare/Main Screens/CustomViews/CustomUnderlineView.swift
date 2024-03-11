//
//  CustomUnderlineView.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

class CustomUnderlineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.snp.makeConstraints { make in
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
        }
        self.backgroundColor = .mainApp.withAlphaComponent(0.42)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
