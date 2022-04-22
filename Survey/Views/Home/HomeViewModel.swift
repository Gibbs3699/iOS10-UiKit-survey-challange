//
//  HomeViewModel.swift
//  Survey
//
//  Created by TheGIZzz on 21/4/2565 BE.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    private var page: Int = 1
    private var pageSize: Int = 20
    private var surveyList = [SurveyAttributes]()
    
    // MARK: - Profile
    
//    func getProfile(_ completion: @escaping (Result<Data, CustomError>) -> Void) {
//        NetworkManager.shared.getProfile() { (result) in
//            print("PPPP get userProfile ---> \(result)")
//            completion(result)
//        }
//    }
    
    // MARK: - SurveyList
//    func getSurveyList(completion: @escaping () -> Void) {
//        NetworkManager.shared.getSurveyList(page: page, pageSize: pageSize) { (result) in
//            switch result {
//            case .success(let data):
//
//                print("getSurveyList data ----> \(data)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    
    
    // MARK: - Configure Home Collection View Cell
    
//    func configureHomeCollectViewCell(cell: HomeCollectionViewCell, at index: Int) {
//        guard filteredCoins.indices.contains(index) else { return }
//
//        let coin = filteredCoins[index].coin
//        let price =  filteredCoins[index].price
//        
//        let homeCollectViewModel = SurveyListViewModel()
//        cell.configure(using: homeCollectViewModel)
//    }
}
