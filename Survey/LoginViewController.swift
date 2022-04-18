//
//  LoginViewController.swift
//  Survey
//
//  Created by TheGIZzz on 15/4/2565 BE.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol logoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    weak var delegate: LoginViewControllerDelegate?

    var email: String? {
        return loginView.emailTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Logo White")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        animate()
    }
    
    func setupView() {
        view.addSubview(loginView)
        view.addSubview(logoImage)
        
        // loginView
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1).isActive = true
        
        // logoImage
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.loginView.signInAction = signInPressed
    }
}

// MARK: - Action

extension LoginViewController {
    @objc func signInPressed() {
        login()
        print("Sign in pressed!!!!!!!")
    }
    
    private func login() {
        guard let email = email, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
//
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
//
        if email == "" && password == "" {
            delegate?.didLogin()
        }else {
            print("Incorrect username / password")
        }
    }
}

// MARK: - Animation

extension LoginViewController {
    private func animate() {
        let originalTransform = logoImage.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.9, y: 0.9)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: -240.0)
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImage.transform = scaledAndTranslatedTransform
        })
    }
}

