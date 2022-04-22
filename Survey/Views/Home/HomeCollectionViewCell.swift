//
//  HomeCollectionViewCell.swift
//  Survey
//
//  Created by TheGIZzz on 18/4/2565 BE.
//

import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    var homeAction: (() -> Void)?
    
    var homePage: HomePage? {
        didSet {
//            print(homePage?.title)
            guard let unwrappedPage = homePage else {
                return
            }
            
            backgroundImage.image = UIImage(named: unwrappedPage.image)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.white])
            
            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedPage.description)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]))
            
            descriptionTextView.attributedText = attributedText
            
            surveyButton.addTarget(self, action: #selector(handleSurvey), for: .touchUpInside)
        
        }
    }
    
    let stackView = UIStackView()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "HomeBackground1"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Working from home Check-In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: "\n\nWe would like to know how you feel about our work from home...", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]))
        
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
        addSubview(backgroundImage)
        addSubview(descriptionTextView)
        addSubview(surveyButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: surveyButton.trailingAnchor, constant: -60),
            descriptionTextView.bottomAnchor.constraint(equalTo: surveyButton.topAnchor, constant: 54)
        ])
        
        NSLayoutConstraint.activate([
            surveyButton.widthAnchor.constraint(equalToConstant: 56),
            surveyButton.heightAnchor.constraint(equalToConstant: 56),
            surveyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            surveyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54)
        ])
    }
    
//    public func configure(using viewModel: SurveyListViewModel) {
//
//
//        configureImage(viewModel.coverImageUrl)
//    }
//
//    private func configureImage(_ imageUrl: String) {
//        guard let url = imageUrl, let placeholderImage = UIImage(named: "HomeBackground1") else {
//                return
//        }
//
//        backgroundView.af_setImage(withURL: url, placeholderImage: placeholderImage)
//    }
}

// MARK: - Action

extension HomeCollectionViewCell {
    @objc func handleSurvey() {
        homeAction?()
//        print("Home action pressed!!!!")
    }
}
