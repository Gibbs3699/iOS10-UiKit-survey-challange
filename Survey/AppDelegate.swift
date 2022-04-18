//
//  AppDelegate.swift
//  Survey
//
//  Created by TheGIZzz on 15/4/2565 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let homeViewController = HomeViewController()
    let splashViewController = SplashViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        loginViewController.delegate = self
        splashViewController.delegate = self
        
        displaySplash()
        
        return true
    }
    
    private func displaySplash() {
        setRootViewController(splashViewController)
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displayHome() {
        setRootViewController(homeViewController)
    }
    

}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayHome()
    }
}

extension AppDelegate: SplashViewControllerDelegate {
    func didFinishedSplash() {
        displayLogin()
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
