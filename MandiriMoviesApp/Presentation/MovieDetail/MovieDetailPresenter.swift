//
//  MovieDetailPresenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol: AnyObject {
    var router: MovieDetailRouter? {get set}
    var interactor: MovieDetailInteractorProtocol? {get set}
    var view: MovieDetailViewProtocol? {get set}
    
    func didPassedMovieData(id: Int, title: String, posterImage: UIImage)
    func didFetchedMovieDetail(result: Result<MovieDetail, Error>)
    func didFetchedMovieTrailer(data: String)

    func navigateToReview()
    func dismissView()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var router: MovieDetailRouter?
    
    var interactor: MovieDetailInteractorProtocol?
    
    weak var view: MovieDetailViewProtocol?
    
    var movieId: Int?
    
    deinit {
        print("presenter deinit")
    }
    
    func didPassedMovieData(id: Int, title: String, posterImage: UIImage){
        self.movieId = id
        view?.update(title: title, posterImage: posterImage)
        interactor?.getDetailMovie(movieId: id)
        interactor?.getTrailerMovie(movieId: id)
    }
    
    func didFetchedMovieDetail(result: Result<MovieDetail, Error>) {
        switch result {
        case .success(let data):
            view?.update(result: .success(data))
        case .failure(let error):
            view?.update(result: .failure(error))
        }
    }
    
    func didFetchedMovieTrailer(data: String) {
        view?.update(trailer: data)
    }
    
    func dismissView() {
        router?.dismissView()
    }
    
    func navigateToReview() {
        router?.navigateToReview(movieId: movieId ?? 0)
    }
    
}
