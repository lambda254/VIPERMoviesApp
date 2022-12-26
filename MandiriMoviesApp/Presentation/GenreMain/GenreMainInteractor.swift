//
//  GenreMainInteractor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import Moya
import SwiftyJSON
import UIKit

protocol GenreMainInteractorProtocol {
    var presenter: GenreMainPresenter? {get set}
    func getGenreMovie()
}

class GenreMainInteractor: GenreMainInteractorProtocol {
    var presenter: GenreMainPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    func getGenreMovie() {
        var data = [GenreMain]()
        networkProvider.request(.fetchGenreData) {[unowned self] result in
            switch result {
            case .success(let response):
                let json = try! JSON(data: response.data)
                let jsonGenres = json["genres"]
                
                for i in 0 ..< jsonGenres.count {
                    let title = jsonGenres[i]["name"].stringValue
                    let id = jsonGenres[i]["id"].intValue
                    data.append(GenreMain(id: id, title: title))
                }
                presenter?.didFetchedGenre(result: .success(data))
            case .failure(let error):
                presenter?.didFetchedGenre(result: .failure(error))
            }
        }
    }
    
    
}
