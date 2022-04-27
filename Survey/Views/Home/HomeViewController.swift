//
//  HomeCollectionViewController.swift
//  Survey
//
//  Created by TheGIZzz on 18/4/2565 BE.
//

import Foundation
import UIKit
import AlamofireImage

protocol HomeViewControllerDelegate: AnyObject {
    func didHome()
}

class HomeViewController: UICollectionViewController {

    private let homeCollectionViewCell = HomeCollectionViewCell()
    
    private var survey: [SurveyAttributes] = [SurveyAttributes]()
    
    var surveyView = SurveyView()
    
    private var pages: [SurveyAttributes] = []
    
    private var viewModel: SurveyListViewModel!
    
    private var page: Int = 1
    
    private var pageSize: Int = 20
    
    weak var delegate: HomeViewControllerDelegate?
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel(placeHolder: "Date", size: 13)
        
        let currentDateTime = Date()
        let dateFormat = currentDateTime.getFormattedDate(format: "EEEE, MMM d")
        
        label.text = "\(dateFormat)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel(placeHolder: "Today", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "HomeBackground2"))
        imageView.layer.cornerRadius = 19
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)

        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        fetchData()
        setupLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let page = pages[indexPath.item]
        
        surveyView.configure(with: page)
        print("PPPP current page ---> \(page)")
        
        cell.surveyView = page
        
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        scrollView.showsHorizontalScrollIndicator = false
        let xPosition = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(xPosition / view.frame.width)
        
    }
}
    
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension HomeViewController {
    func setupLayout() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(todayLabel)
        view.addSubview(stackView)
        view.addSubview(userImage)
        view.addSubview(pageControl)
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 100)
        ])
        
        // userImage
        NSLayoutConstraint.activate([
            userImage.widthAnchor.constraint(equalToConstant: 36),
            userImage.heightAnchor.constraint(equalToConstant: 36),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            userImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // pageControl
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalToConstant: 48),
            pageControl.heightAnchor.constraint(equalToConstant: 8),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -210)
        ])
        
    }
}

// MARK: - Action

extension HomeViewController {
    @objc func handleSurvey() {
        let surveyViewController: SurveyViewController = SurveyViewController()

        surveyViewController.modalPresentationStyle = .fullScreen
        surveyViewController.modalTransitionStyle = .coverVertical
        present(surveyViewController, animated: true, completion: nil)
        
        delegate?.didHome()
    }
}
// MARK: - Networking

extension HomeViewController {
    func fetchData() {
        NetworkManager().getSurveyList(page: page, pageSize: pageSize) { result in
            switch result {
            case .success(let survey):
                
                survey.forEach({ self.pages.append($0)})
                self.pages = survey
                
                self.pageControl.numberOfPages = survey.count
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        NetworkManager().getUser { result in
            switch result {
            case .success(let user):
            
                let userInfo = user.data.attributes
                
                print("PPPP user image ---> \(    userInfo.avatarUrl)")
                
                self.configureImage(userInfo.avatarUrl)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureImage(_ image: String) {
        guard let url = URL(string: image) else {
            return
        }
        let placeholderImage = UIImage(named: "HomeBackground1")
        
        userImage.af.setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
