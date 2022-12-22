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
    
    var interactor: MainInteractorProtocol?
    
    var view: MainViewProtocol?
    
    func didFetchMovies(with result: Result<[MovieMain], Error>) {
        
    }
    
    
}
