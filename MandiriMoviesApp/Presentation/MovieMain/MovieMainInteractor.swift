//
//  Interactor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import Moya
import SwiftyJSON

protocol MovieMainInteractorProtocol {
    var presenter: MovieMainPresenter? {get set}
    
    func getMovies(genreId: Int, page: Int, completion: @escaping ([MovieMain]) -> Void)
    func getPosterImage(imageString: String, completion: @escaping (UIImage) -> Void)
}

class MovieMainInteractor: MovieMainInteractorProtocol {
    var presenter: MovieMainPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    func getMovies(genreId: Int, page: Int, completion: @escaping ([MovieMain]) -> Void) {
        var data = [MovieMain]()
        var endCounter = 0
        networkProvider.request(.fetchAllMovieTitle(page: page, genreId: genreId)) {[self] result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonResult = json["results"]
                for i in 0 ..< jsonResult.count {
                    data.append(MovieMain(id: jsonResult[i]["id"].int ?? 0, title: jsonResult[i]["title"].string ?? "", poster: jsonResult[i]["poster_path"].string ?? "", posterImage: UIImage()))
                }
                for i in 0 ..< data.count {
                    getPosterImage(imageString: data[i].poster) {[unowned self] image in
                        data[i].posterImage = image
                        endCounter += 1
                        if endCounter == data.count {
                            completion(data)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPosterImage(imageString: String, completion: @escaping (UIImage) -> Void) {
        networkProvider.request(.fetchAllMoviePoster(image: imageString)) { result in
            switch result {
            case .success(let response):
                if let image = UIImage(data: response.data) {
                    completion(image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
