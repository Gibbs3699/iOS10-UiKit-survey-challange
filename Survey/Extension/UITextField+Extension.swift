//
//  UITextField+Extension.swift
//  Survey
//
//  Created by TheGIZzz on 16/4/2565 BE.
//

import UIKit

extension UITextField {
    public convenience init(placeHolder: String) {
        self.init()
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.18)
        self.textColor = UIColor(white: 1.0, alpha: 1.0)
        self.font = UIFont.systemFont(ofSize: 17)
        self.placeholder = placeHolder
        self.setLeftPaddingPoints(13)
    }
}

