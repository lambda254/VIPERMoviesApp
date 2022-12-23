//
//  Presenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol MovieMainPresenterProtocol {
    var router: MovieMainRouter? {get set}
    var interactor: MovieMainInteractorProtocol? {get set}
    var view: MovieMainViewProtocol? {get set}
    
    func didFetchMovies(with result: Result<[MovieMain], Error>)
    func didPassedGenreId(genreId: Int, title: String)
    
    func navigateToDetail(id: Int, title: String, poster: UIImage)
}

class MovieMainPresenter: MovieMainPresenterProtocol {
    var router: MovieMainRouter?
    
    var interactor: MovieMainInteractorProtocol?
    
    var view: MovieMainViewProtocol?
    
    func didFetchMovies(with result: Result<[MovieMain], Error>) {
        switch result {
        case .success(let movies):
            view?.update(with: movies)
        case .failure(let errors):
            print(errors)
        }
    }
    
    func didPassedGenreId(genreId: Int, title: String) {
        interactor?.getMovies(genreId: genreId)
        view?.update(title: title)
    }
    
    func navigateToDetail(id: Int, title: String, poster: UIImage) {
        router?.navigateToDetail(id: id, title: title, poster: poster)
    }
    
    
}
