//
//  SurveyView.swift
//  Survey
//
//  Created by TheGIZzz on 19/4/2565 BE.
//

import UIKit

class SurveyView: UIView {

    var surveyAction: (() -> Void)?
    var backAction: (() -> Void)?
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HomeBackground1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let startSurveyButton: UIButton = {
        let button = UIButton(title: "Start Survey")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSurvey), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Title", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: "Description", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SurveyView {
    func layout() {
        addSubview(backgroundImage)
        addSubview(backButton)
        addSubview(descriptionTextView)
        addSubview(startSurveyButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 22)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 6),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            startSurveyButton.widthAnchor.constraint(equalToConstant: 140),
            startSurveyButton.heightAnchor.constraint(equalToConstant: 56),
            startSurveyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54),
            startSurveyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
    }
}

// MARK: - Action

extension SurveyView {
    
    @objc func handleSurvey() {
        surveyAction?()
    }
    
    @objc func handleBack() {
        backAction?()
    }
}
