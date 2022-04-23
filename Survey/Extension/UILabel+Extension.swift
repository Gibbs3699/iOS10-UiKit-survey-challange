//
//  UILabel+Extension.swift
//  Survey
//
//  Created by TheGIZzz on 23/4/2565 BE.
//

import UIKit

extension UILabel {
    public convenience init(placeHolder: String, size: Int) {
        self.init()
        self.textColor = UIColor(white: 1.0, alpha: 1.0)
        self.font = UIFont.systemFont(ofSize: CGFloat(size), weight: .bold)
        self.text = placeHolder
    }
}
