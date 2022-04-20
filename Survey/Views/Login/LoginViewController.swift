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
    
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    weak var delegate: LoginViewControllerDelegate?

    var email: String? {
        return loginView.emailTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo White")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1)
        ])
        
        // logoImage
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 48),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.loginView.signInAction = signInPressed
    }
}

// MARK: - Action

extension LoginViewController {
    
    @objc func signInPressed() {
        login()
//        print("Sign in pressed!!!!!!!")
    }
    
    private func login() {
        guard let email = email, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        viewModel.login(email: email, password: password)
//
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
//
//        if email == "" && password == "" {
//            delegate?.didLogin()
//        }else {
//            print("Incorrect username / password")
//        }
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
