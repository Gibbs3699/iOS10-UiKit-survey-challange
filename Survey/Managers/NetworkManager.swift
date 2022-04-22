//
//  NetworkManager.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Alamofire

protocol Gettable {
    func authorize(parameters: [String: Any]?, completion: @escaping (Result<Data, CustomError>) -> Void)
    func getProfile(completion: @escaping (Result<Data, CustomError>) -> Void)
    func getSurveyList(page: Int, pageSize: Int ,completion: @escaping (Result<SurveyList, CustomError>) -> Void)
}

class NetworkManager: Gettable {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    var request: Alamofire.Request?
    let retryLimit = 3
    
    func authorize(parameters: [String: Any]?, completion: @escaping (Result<Data, CustomError>) -> Void) {
        request?.cancel()
        request = AF.request(APIClient.authorizeUrl(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
    
    func getProfile(completion: @escaping (Result<Data, CustomError>) -> Void) {
        AF.request(APIClient.profileUrl(), method: .get,
                   headers: APIClient.headers()).responseJSON { (response) in
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
    
    func getSurveyList(page: Int, pageSize: Int, completion: @escaping (Result<SurveyList, CustomError>) -> Void) {
        AF.request(APIClient.surveyListUrl(page: page, pageSize: pageSize), method: .get, headers: APIClient.headers()).responseData { (response) in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    if let error = response.error {
                        print("Handle Error Please: \(error)")
                    }
                    
                    guard let data = response.data else {
                        print("no daata")
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(SurveyList.self, from: data)
                        
                        completion(.success(result))
                        
//                        print("surveyList : \(String(describing: data))")
                    }
                    catch let decodeError {
                        print("Failed to decode, Handle Error here: \(decodeError)")
                    }
                default:
                    completion(.failure(.unavailableServer))
                    print("PPPP request ---> fail (not 201)")
                }
            case .failure:
                completion(.failure(.unavailableServer))
                print("PPPP request ---> failure case")
            }
        }
    }
    
    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil, completion: @escaping (Result<Data, CustomError>) -> Void) {
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
