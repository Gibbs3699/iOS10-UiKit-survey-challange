//
//  UIButton+Extension.swift
//  Survey
//
//  Created by TheGIZzz on 16/4/2565 BE.
//

import UIKit

extension UIButton {
    public convenience init(title: String) {
        self.init()
        self.setTitle(title, for: [])
        self.setTitleColor(.black, for: [])
        self.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .bold)
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
    }
}
