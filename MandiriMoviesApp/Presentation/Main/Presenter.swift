//
//  Presenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation

protocol MainPresenterProtocol {
    var router: MainRouter? {get set}
    var interactor: MainInteractorProtocol? {get set}
    var view: MainViewProtocol? {get set}
    
    func didFetchMovies(with result: Result<[MovieMain], Error>)
}

class MainPresenter: MainPresenterProtocol {
    var router: MainRouter?
    
    var interactor: MainInteractorProtocol? {
        didSet {
            interactor?.getMovies()
        }
    }
    
    var view: MainViewProtocol?
    
    func didFetchMovies(with result: Result<[MovieMain], Error>) {
        switch result {
        case .success(let movies):
            view?.update(with: movies)
        case .failure(let errors):
            print(errors)
        }
    }
    
    
}
