//
//  NetworkManager+RequestInterceptor.swift
//  Survey
//
//  Created by TheGIZzz on 21/4/2565 BE.
//

import Alamofire
extension NetworkManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let accessToken = UserDefaultsManager.shared.getAccessToken() else {
            completion(.success(urlRequest))
            return
        }
        let bearerToken = "Bearer \(accessToken)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let clientId = UserDefaultsManager.shared.getUserClient().clientId,
            let clientSecret = UserDefaultsManager.shared.getUserClient().clientSecret,
            let refreshToken = UserDefaultsManager.shared.getRefreshToken()
            else { return }
        let parameters = ["grant_type": "refresh_token", "refresh_token": refreshToken,"client_id": clientId, "client_secret": clientSecret]
        AF.request(authorize, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    if let data = response.data, let accessToken = (try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any])?["access_token"] as? String {
                        UserDefaultsManager.shared.setAccessToken(accessToken: accessToken)
                        print("\nRefresh token completed successfully. New token is: \(accessToken)\n")
                        completion(true)
                    } else {
                        completion(false)
                    }
                default:
                    completion(false)
                }
            case .failure:
                completion(false)
            }
        }
    }
    
}
