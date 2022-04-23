//
//  ThankYouViewController.swift
//  Survey
//
//  Created by TheGIZzz on 19/4/2565 BE.
//

import UIKit
import Lottie

class ThankYouViewController: UIViewController {

    let animationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.082, green: 0.082, blue: 0.102, alpha: 1)
        
        setupAnimation()
        layout()
    }

    private let titleTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Thanks for taking the survey.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
}

extension ThankYouViewController {
    
    private func setupAnimation() {
        animationView.animation = Animation.named("checkMark")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
        view.addSubview(animationView)
        view.addSubview(titleTextView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60)
        ])
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 0),
            titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
