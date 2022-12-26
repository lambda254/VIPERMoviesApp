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
        
    func didPassedGenreId(genreId: Int, title: String)
    func didFetchedMovie(result: Result<[MovieMain], Error>)
    
    func navigateToDetail(id: Int, title: String, poster: UIImage)
    func fetchNewMovies()
}

class MovieMainPresenter: MovieMainPresenterProtocol {
    var router: MovieMainRouter?
    
    var interactor: MovieMainInteractorProtocol?
    
    weak var view: MovieMainViewProtocol?
        
    var genreId: Int?
    
    deinit {
        print("presenter deinit")
    }
    
    func didPassedGenreId(genreId: Int, title: String) {
        self.genreId = genreId
        view?.update(title: title)
        fetchNewMovies()
    }
    
    func didFetchedMovie(result: Result<[MovieMain], Error>) {
        switch result {
        case .success(let data):
            view?.update(result: .success(data))
        case .failure(let error):
            view?.update(result: .failure(error))
        }
    }
    
    func navigateToDetail(id: Int, title: String, poster: UIImage) {
        router?.navigateToDetail(id: id, title: title, poster: poster)
    }
    
    func fetchNewMovies() {
        interactor?.getMovies(genreId: genreId ?? 0)
    }
    
}
