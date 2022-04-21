//
//  UserDefaultsManager.swift
//  Survey
//
//  Created by TheGIZzz on 20/4/2565 BE.
//

import Foundation
class UserDefaultsManager {
    enum Key: String {
        case clientId
        case clientSecret
        case accessToken
        case refreshToken
        case isSignedIn
    }
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    func getUserClient() -> (clientId: String?, clientSecret: String?) {
        let clientId = UserDefaults.standard.string(forKey: Key.clientId.rawValue)
        let clientSecret = UserDefaults.standard.string(forKey: Key.clientSecret.rawValue)
        return (clientId, clientSecret)
    }
    func setUserClient(clientId: String, clientSecret: String) {
        UserDefaults.standard.set(clientId, forKey: Key.clientId.rawValue)
        UserDefaults.standard.set(clientSecret, forKey: Key.clientSecret.rawValue)
        UserDefaults.standard.synchronize()
    }
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Key.accessToken.rawValue)
    }
    func setAccessToken(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: Key.refreshToken.rawValue)
    }
    func setRefreshToken(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    func signInUser() {
        UserDefaults.standard.set(true, forKey: Key.isSignedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
    func signOutUser() {
        UserDefaults.standard.set(false, forKey: Key.isSignedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
    func isUserSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Key.isSignedIn.rawValue)
    }
    func signIn(clientId: String, clientSecret: String, accessToken: String, refreshToken: String) {
        setUserClient(clientId: clientId, clientSecret: clientSecret)
        setAccessToken(accessToken: accessToken)
        setRefreshToken(refreshToken: refreshToken)
        signInUser()
    }
}
