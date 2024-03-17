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
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        snp.makeConstraints { make in
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
        }
        backgroundColor = .mainApp.withAlphaComponent(0.42)
    }

}
