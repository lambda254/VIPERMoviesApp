//
//  MovieDetailInteractor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import Moya
import SwiftyJSON
import UIKit

protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailPresenter? {get set}
    func getDetailMovie(movieId: Int)
    func getTrailerMovie(movieId: Int)
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var presenter: MovieDetailPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    deinit {
        print("interactor deinit")
    }
    
    func getDetailMovie(movieId: Int){
        var genresData = [String]()
        networkProvider.request(.fetchDetailData(movieId: movieId)) {[unowned self] result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let synopsis = json["overview"].stringValue
                let genres = json["genres"]
                let homepage = json["homepage"].stringValue
                let rating = json["vote_average"].doubleValue
                
                for i in 0 ..< genres.count {
                    genresData.append(genres[i]["name"].string ?? "")
                }
                
                presenter?.didFetchedMovieDetail(data: MovieDetail(id: movieId, synopsis: synopsis, genres: genresData, homepage: homepage, rating: rating))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTrailerMovie(movieId: Int){
        var data = ""
        networkProvider.request(.fetchTrailerData(movieId: movieId)) {[unowned self] result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonResult = json["results"]
                for i in 0 ..< jsonResult.count {
                    if jsonResult[i]["type"].string == "Trailer" {
                        data = jsonResult[i]["key"].string ?? ""
                    }
                }
                presenter?.didFetchedMovieTrailer(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
