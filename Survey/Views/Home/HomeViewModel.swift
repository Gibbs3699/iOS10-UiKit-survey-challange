//
//  HomeViewModel.swift
//  Survey
//
//  Created by TheGIZzz on 21/4/2565 BE.
//

import Foundation

class HomeViewModel {
    
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
                    //
                }
            case .failure(let error):
                print(error)
                self.error.value = "Login invalid!!!"
            }
        }
    }
}
