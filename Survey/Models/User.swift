//
//  User.swift
//  Survey
//
//  Created by TheGIZzz on 22/4/2565 BE.
//

import Foundation

struct User: Decodable {
    var data: UserInfo
}

struct UserInfo: Decodable {
    let id: String
    let attributes: UserAttributes
}

struct UserAttributes: Decodable {
    let email: String
    let name: String
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case email
        case name
        case avatarUrl = "avatar_url"
    }
}
