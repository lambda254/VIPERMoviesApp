//
//  MovieDetailPresenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    var router: MovieDetailRouter? {get set}
    var interactor: MovieDetailInteractorProtocol? {get set}
    var view: MovieDetailViewProtocol? {get set}
    
    func didPassedMovieData(id: Int, title: String, posterImage: UIImage)
    
    func navigateToReview()
    func dismissView()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var router: MovieDetailRouter?
    
    var interactor: MovieDetailInteractorProtocol?
    
    var view: MovieDetailViewProtocol?
    
    var movieId: Int?

    func didPassedMovieData(id: Int, title: String, posterImage: UIImage){
        self.movieId = id
        view?.update(title: title, posterImage: posterImage)
        interactor?.getDetailMovie(movieId: id, completion: {[unowned self] data in
            view?.update(with: data)
        })
        interactor?.getTrailerMovie(movieId: id, completion: { [unowned self] data in
            view?.update(trailer: data)
        })
    }
    
    func dismissView() {
        router?.dismissView()
    }
    
    func navigateToReview() {
        router?.navigateToReview(movieId: movieId ?? 0)
    }
    
}
