//
//  HomeCollectionViewCell.swift
//  Survey
//
//  Created by TheGIZzz on 18/4/2565 BE.
//

import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    var homeAction: (() -> Void)?
    
    var surveyView: SurveyAttributes? {
        didSet {
            guard let unwrappedSurvey = surveyView else {
                return
            }

            guard let url = URL(string: unwrappedSurvey.coverImageUrl) else {
                return
            }
            let placeholderImage = UIImage(named: "HomeBackground1")
            
            backgroundImage.af.setImage(withURL: url, placeholderImage: placeholderImage)

            let attributedText = NSMutableAttributedString(string: unwrappedSurvey.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.white])

            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedSurvey.description)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]))

            descriptionTextView.attributedText = attributedText

            surveyButton.addTarget(self, action: #selector(handleSurvey), for: .touchUpInside)

        }
    }
    
    let stackView = UIStackView()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "HomeBackground2"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addoverlay()
        return imageView
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
    
    private let surveyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Survey Button"), for: .normal)
        button.addTarget(self, action: #selector(handleSurvey), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewCell {
    func setupLayout() {
        backgroundColor = .black
        addSubview(backgroundImage)
        addSubview(descriptionTextView)
        addSubview(surveyButton)
        
        // backgroundImage
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // descriptionTextView
        NSLayoutConstraint.activate([
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: surveyButton.trailingAnchor, constant: -60),
            descriptionTextView.bottomAnchor.constraint(equalTo: surveyButton.topAnchor, constant: 54)
        ])
        
        // surveyButton
        NSLayoutConstraint.activate([
            surveyButton.widthAnchor.constraint(equalToConstant: 56),
            surveyButton.heightAnchor.constraint(equalToConstant: 56),
            surveyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            surveyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54)
        ])
    }
}

// MARK: - Action

extension HomeCollectionViewCell {
    @objc func handleSurvey() {
        homeAction?()
    }
}
