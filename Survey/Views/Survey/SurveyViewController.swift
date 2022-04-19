//
//  SurveyViewController.swift
//  Survey
//
//  Created by TheGIZzz on 19/4/2565 BE.
//

import UIKit

protocol SurveyViewControllerDelegate: AnyObject {
    func didSurvey()
}

class SurveyViewController: UIViewController {

    let surveyView = SurveyView()
    
    weak var delegate: SurveyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(surveyView)
        
        // surveyView
        surveyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            surveyView.topAnchor.constraint(equalTo: view.topAnchor),
            surveyView.leftAnchor.constraint(equalTo: view.leftAnchor),
            surveyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            surveyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.surveyView.surveyAction = surveyPressed
    }

}

// MARK: - Action

extension SurveyViewController {
    
    @objc func surveyPressed() {
        print("Survey in pressed!!!!!!!")
        delegate?.didSurvey()
    }

}

