//
//  MovieReviewInteractor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import Moya
import SwiftyJSON
import UIKit

protocol MovieReviewInteractorProtocol {
    var presenter: MovieReviewPresenter? {get set}
    
    func getReviewData(movieId: Int, completion: @escaping ([MovieReview]) -> Void)

}

class MovieReviewInteractor: MovieReviewInteractorProtocol {
    var presenter: MovieReviewPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    private var page = 0
    
    func getReviewData(movieId: Int, completion: @escaping ([MovieReview]) -> Void) {
        var data = [MovieReview]()
        page += 1
        networkProvider.request(.fetchReviewData(movieId: movieId, page: page)) { result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonResult = json["results"]
            
                for i in 0 ..< jsonResult.count {
                    data.append(MovieReview(username: jsonResult[i]["author"].string ?? "", review: jsonResult[i]["content"].string ?? ""))
                }
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
