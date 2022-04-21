//
//  NetworkManager.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Alamofire

class NetworkManager {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    typealias CompletionHandler = ((Result<Data, CustomError>) -> Void)
    
    var request: Alamofire.Request?
    let retryLimit = 3
    let authorize = "https://survey-api.nimblehq.co/api/v1/oauth/token"
    let profile = "https://survey-api.nimblehq.co/api/v1/me"
    
    func authorize(parameters: [String: Any]?, completion: @escaping CompletionHandler) {
        request?.cancel()
        request = AF.request(authorize, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.unavailableServer))
                    }
                default:
                    completion(.failure(.unavailableServer))
                }
            case .failure:
                completion(.failure(.unavailableServer))
            }
        }
    }
    
    func getProfile(parameters: [String: Any]?, header: [String: Any]?, completion: @escaping CompletionHandler) {
        request?.cancel()
        request = AF.request(profile, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.unavailableServer))
                    }
                default:
                    completion(.failure(.unavailableServer))
                }
            case .failure:
                completion(.failure(.unavailableServer))
            }
        }
    }
    
    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil, completion: @escaping CompletionHandler) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding,
                   headers: headers, interceptor: interceptor ?? self).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    if let data = response.data {
                        completion(.success(data))
                        print("PPPP request ---> success")
                    } else {
                        completion(.failure(.unavailableServer))
                        print("PPPP request ---> fail")
                    }
                default:
                    completion(.failure(.unavailableServer))
                    print("PPPP request ---> fail (not 200)")
                }
            case .failure:
                completion(.failure(.unavailableServer))
                print("PPPP request ---> failure case")
            }
        }
    }
    
}
