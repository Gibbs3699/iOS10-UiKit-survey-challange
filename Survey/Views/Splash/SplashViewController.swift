//
//  SplashViewController.swift
//  Survey
//
//  Created by TheGIZzz on 17/4/2565 BE.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func didSplash()
}

class SplashViewController: UIViewController {

    weak var delegate: SplashViewControllerDelegate?
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Splash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo White")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        animate()
    }
    
    
    func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        
        // overlayImage
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // logoImage
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - Animation

extension SplashViewController {
    private func animate() {
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn,  animations: {
            self.logoImage.alpha = 1.0
        }, completion: {done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.delegate?.didSplash()
                })
            }
        })
    }
}
