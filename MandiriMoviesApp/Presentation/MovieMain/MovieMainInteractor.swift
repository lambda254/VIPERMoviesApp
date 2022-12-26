//
//  Interactor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import Moya
import SwiftyJSON

protocol MovieMainInteractorProtocol: AnyObject {
    var presenter: MovieMainPresenter? {get set}
    
    func getMovies(genreId: Int)
    func getPosterImage(imageString: String, completion: @escaping (UIImage) -> Void)
}

class MovieMainInteractor: MovieMainInteractorProtocol {
    weak var presenter: MovieMainPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    private var page = 0
    
    deinit {
        print("interactor deinit")
    }
    
    func getMovies(genreId: Int) {
        var data = [MovieMain]()
        var endCounter = 0
        page += 1
        networkProvider.request(.fetchAllMovieTitle(page: page, genreId: genreId)) {[self] result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonResult = json["results"]
                for i in 0 ..< jsonResult.count {
                    data.append(MovieMain(id: jsonResult[i]["id"].int ?? 0, title: jsonResult[i]["title"].string ?? "", poster: jsonResult[i]["poster_path"].string ?? "", posterImage: UIImage()))
                }
                for i in 0 ..< data.count {
                    getPosterImage(imageString: data[i].poster) {[weak self] image in
                        data[i].posterImage = image
                        endCounter += 1
                        if endCounter == data.count {
                            self?.presenter?.didFetchedMovie(result: .success(data))
                        }
                    }
                }
            case .failure(let error):
                presenter?.didFetchedMovie(result: .failure(error))
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
