//
//  loginViewModel.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Foundation

class LoginViewModel {
    
    var grantType: String = "password"
    var clientId: String = "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw"
    var clientSecret: String = "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw"
    var apiKey: String = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
    var secretKey: String = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
    
    func login(email: String, password: String) {
        let parameters = ["grant_type": grantType, "email": email, "password": password, "client_id": clientId, "client_secret": clientSecret]
        NetworkManager.shared.authorize(parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                if let token = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])?["access_token"] as? String {
                    UserDefaultsManager.shared.signIn(apiKey: self.apiKey, secretKey: self.secretKey, token: token)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
