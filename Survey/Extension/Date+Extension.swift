//
//  Date+Extension.swift
//  Survey
//
//  Created by TheGIZzz on 23/4/2565 BE.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
