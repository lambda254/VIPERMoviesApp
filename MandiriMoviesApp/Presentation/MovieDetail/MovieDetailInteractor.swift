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

protocol MovieDetailInteractorProtocol {
    var presenter: MovieDetailPresenter? {get set}
    func getDetailMovie(movieId: Int, completion: @escaping (MovieDetail) -> Void)
    func getTrailerMovie(movieId: Int, completion: @escaping (String) -> Void)
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    var presenter: MovieDetailPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    func getDetailMovie(movieId: Int, completion: @escaping (MovieDetail) -> Void){
        var genresData = [String]()
        networkProvider.request(.fetchDetailData(movieId: movieId)) { result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let synopsis = json["overview"].string ?? ""
                let genres = json["genres"]
                let homepage = json["homepage"].string ?? ""
                
                for i in 0 ..< genres.count {
                    genresData.append(genres[i]["name"].string ?? "")
                }
                
                completion(MovieDetail(synopsis: synopsis, genres: genresData, homepage: homepage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTrailerMovie(movieId: Int, completion: @escaping (String) -> Void){
        var data = ""
        networkProvider.request(.fetchTrailerData(movieId: movieId)) { result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonResult = json["results"]
                for i in 0 ..< jsonResult.count {
                    if jsonResult[i]["type"].string == "Trailer" {
                        data = jsonResult[i]["key"].string ?? ""
                    }
                }
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
