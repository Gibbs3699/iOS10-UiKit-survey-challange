//
//  APIClient.swift
//  Survey
//
//  Created by TheGIZzz on 22/4/2565 BE.
//

import Foundation
import Alamofire

public struct APIClient {
    
    #if PRO
    static let apiUrl = "https://survey-api.nimblehq.co"
    #else
    static let apiUrl = "https://nimble-survey-web-staging.herokuapp.com/"
    #endif
    
//    static let apiUrl: String =  "https://survey-api.nimblehq.co"
    
    static func authorizeUrl() -> String {
        return "\(apiUrl)/api/v1/oauth/token"
    }
    
    static func profileUrl() -> String {
        return "\(apiUrl)/api/v1/me"
    }
    
    static func surveyListUrl(page: Int, pageSize: Int) -> String {
        return "\(apiUrl)/api/v1/surveys?page[number]=\(page)&page[size]=\(pageSize)"
    }
    
    static func headers() -> HTTPHeaders {
        
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        if let authToken = UserDefaultsManager.shared.getAccessToken() {
            headers["Authorization"] = "Bearer" + " " + authToken
        }

        return headers
    }

}
