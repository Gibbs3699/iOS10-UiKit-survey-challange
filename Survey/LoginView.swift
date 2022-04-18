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
//        overlay.applyBlurEffect()
        return overlay
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField(placeHolder: "Email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(placeHolder: "Password")
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        overlayImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overlayImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        overlayImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        overlayImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        // emailTextField
        emailTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        // passwordTextField
        passwordTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        // signInButton
        signInButton.widthAnchor.constraint(equalToConstant: 327).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}

// MARK: - Action

extension LoginView {
    @objc func handleSignIn() {
        signInAction?()
    }
}
