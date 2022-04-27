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
    
    struct ViewModel {
        let title: String
        let description: String
        let coverImageUrl: String
    }
    
    let viewModel: ViewModel? = nil
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel(placeHolder: "Title", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(placeHolder: "Description", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SurveyView {
    func setupLayout() {
        addSubview(backgroundImage)
        addSubview(backButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        addSubview(startSurveyButton)
        
        // backgroundImage
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // backButton
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 22)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 6),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // startSurveyButton
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

// MARK: - configure survey view

extension SurveyView {
    
    func configure(with viewModel: SurveyAttributes) {

        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
            self.configureImage(viewModel.coverImageUrl)
        }

    }
    
    private func configureImage(_ image: String) {
        guard let url = URL(string: image) else {
            return
        }
        let placeholderImage = UIImage(named: "HomeBackground1")
        
        backgroundImage.af.setImage(withURL: url, placeholderImage: placeholderImage)
    }

}
