//
//  LoginViewController.swift
//  Survey
//
//  Created by TheGIZzz on 15/4/2565 BE.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(loginView)
        
        // loginView
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1).isActive = true
        
        self.loginView.signInAction = signInPressed
    }
}

// MARK: - Action

extension LoginViewController {
    @objc func signInPressed() {
        print("Sign in pressed!!!!!!!")
    }
}
