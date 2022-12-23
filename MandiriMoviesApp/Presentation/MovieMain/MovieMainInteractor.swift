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
    
    func getMovies(genreId: Int, page: Int)
    func getPosterImage(imageString: String, completion: @escaping (UIImage) -> Void)
}

class MovieMainInteractor: MovieMainInteractorProtocol {
    var presenter: MovieMainPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    func getMovies(genreId: Int, page: Int) {
        var data = [MovieMain]()
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
                        presenter?.didFetchMovies(with: .success(data))
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
