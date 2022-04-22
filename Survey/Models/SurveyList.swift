//
//  SurveyList.swift
//  Survey
//
//  Created by TheGIZzz on 22/4/2565 BE.
//

import Foundation

struct SurveyList: Decodable {
    var data: [Survey]
}

struct Survey: Decodable {
    let id: String
    let attributes: SurveyAttributes
}

struct SurveyAttributes: Decodable {
    let title: String
    let description: String
    let coverImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case coverImageUrl = "cover_image_url"
    }
}
