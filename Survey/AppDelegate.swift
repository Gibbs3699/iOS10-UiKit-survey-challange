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
    let surveyViewController = SurveyViewController()
    let splashViewController = SplashViewController()
    let thankYouViewController = ThankYouViewController()
    
    let layout = UICollectionViewFlowLayout()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        loginViewController.delegate = self
        splashViewController.delegate = self
        homeViewController.delegate = self
        surveyViewController.delegate = self
        
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
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        
        setRootViewController(homeViewController)
    }
    
    private func displaySurvey() {
        setRootViewController(surveyViewController)
    }
    
    private func displayThankyou() {
        setRootViewController(thankYouViewController)
    }

}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        displayHome()
    }
}

extension AppDelegate: SplashViewControllerDelegate {
    func didSplash() {
        displayLogin()
    }
}

extension AppDelegate: HomeViewControllerDelegate {
    func didHome() {
        displaySurvey()
    }
}

extension AppDelegate: SurveyViewControllerDelegate {
    func didSurvey() {
        displayThankyou()
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

