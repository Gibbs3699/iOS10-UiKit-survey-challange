//
//  SurveyListViewModel.swift
//  Survey
//
//  Created by TheGIZzz on 22/4/2565 BE.
//

import Foundation

struct SurveyViewModel {
    private let surveys: SurveyAttributes
    
    var title: String
    var description: String
    var coverImageUrl: String
    
    init(_ survey: SurveyAttributes) {
        self.surveys = survey
        self.title = survey.title
        self.description = survey.description
        self.coverImageUrl = survey.coverImageUrl
    }
}

struct SurveyListViewModel {
    let surveys: [SurveyAttributes]
}
