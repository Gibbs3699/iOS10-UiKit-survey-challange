//
//  CustomError.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Foundation
enum CustomError: String, Error {
    case authorize = "Unable to authenticate user. An error occurred during authorization, please check your connection and try again."
    case unavailableServer = "Server is unavailable"
}
