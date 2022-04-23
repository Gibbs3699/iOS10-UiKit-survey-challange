//
//  Extension.swift
//  Survey
//
//  Created by TheGIZzz on 15/4/2565 BE.
//

import UIKit

extension UIView {
func addoverlay(color: UIColor = .black, alpha: CGFloat = 0.5) {
    let overlay = UIView()
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.frame = bounds
    overlay.backgroundColor = color
    overlay.alpha = alpha
    addSubview(overlay)
    }
}
