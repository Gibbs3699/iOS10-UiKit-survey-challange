//
//  LoginViewModel.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Foundation

class LoginViewModel {
    
    var grantType: String = "password"
    var clientId: String = "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw"
    var clientSecret: String = "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw"
    
    var error: ObservableObject<String?> = ObservableObject("")
    
    func login(email: String, password: String) {
        let parameters = ["grant_type": grantType, "email": email, "password": password, "client_id": clientId, "client_secret": clientSecret]
        NetworkManager.shared.authorize(parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                if let json = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) {
                    if let datas = json["data"] as? [String: Any] {
                        if let attrs = datas["attributes"] as? [String: Any] {
                            if let accessToken = attrs["access_token"] as? String {
                                if let refreshToken = attrs["refresh_token"] as? String {
                                    UserDefaultsManager.shared.signIn(clientId: self.clientId, clientSecret: self.clientSecret, accessToken: accessToken, refreshToken: refreshToken)
                                    
                                    self.error.value = nil
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
                self.error.value = "Login invalid!!!"
            }
        }
    }
}
