//
//  LoginView.swift
//  Survey
//
//  Created by TheGIZzz on 15/4/2565 BE.
//

import UIKit

class LoginView: UIView {

    var signInAction: (() -> Void)?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let overlayImage: UIImageView = {
        let overlay = UIImageView()
        overlay.image = UIImage(named: "Image")
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField(placeHolder: "Email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "dev@nimblehq.co"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(placeHolder: "Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.text = "12345678"
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(title: "Log in")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(overlayImage)
//        addSubview(logoImage)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
        addSubview(stackView)
        
        // overlayImage
        NSLayoutConstraint.activate([
            overlayImage.topAnchor.constraint(equalTo: topAnchor),
            overlayImage.leftAnchor.constraint(equalTo: leftAnchor),
            overlayImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // emailTextField
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 327),
            emailTextField.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 327),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        // signInButton
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 327),
            signInButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

}

// MARK: - Action

extension LoginView {
    @objc func handleSignIn() {
        signInAction?()
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
}
