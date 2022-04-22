//
//  HomeCollectionViewController.swift
//  Survey
//
//  Created by TheGIZzz on 18/4/2565 BE.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didHome()
}

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {

    let homeCollectionViewCell = HomeCollectionViewCell()
    
    private var viewModel: SurveyListViewModel!
    
    private var page: Int = 1
    
    private var pageSize: Int = 20
    
    var pages: [HomePage] = []
    
    weak var delegate: HomeViewControllerDelegate?
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        pages = [
            HomePage(title: "Working from home Check-In", description: "We would like to know how you feel about our work from home...", image: "HomeBackground1"),
            HomePage(title: "Career training and development", description: "We would like to know what are your goals and skills you wanted...", image: "HomeBackground2"),
            HomePage(title: "Inclusion and belonging", description: "Building a workplace culture that prioritizes belonging and inclusio...", image: "HomeBackground3")
        ]
        
        setupLayout()
        fetchSurveyList()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("failed while casting")
        }
    
        let page = pages[indexPath.item]
        cell.homePage = page
        
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
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
        view.addSubview(pageControl)
//        view.addSubview(surveyButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalToConstant: 48),
            pageControl.heightAnchor.constraint(equalToConstant: 8),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -206)
        ])
        
    }
}

// MARK: - Action

extension HomeViewController {
    @objc func handleSurvey() {
        let surveyViewController:SurveyViewController = SurveyViewController()

        surveyViewController.modalPresentationStyle = .fullScreen
        surveyViewController.modalTransitionStyle = .coverVertical
        present(surveyViewController, animated: true, completion: nil)
//        print("Home button is pressed!!!!!!!!!!!!!!!!!!")
        
        delegate?.didHome()
    }
}

extension HomeViewController {
    private func fetchSurveyList() {
        NetworkManager().getSurveyList(page: page, pageSize: pageSize) { result in
            switch result {
            case .success(let accounts):
              print("ffffff ----> \(accounts)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
