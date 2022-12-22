//
//  Presenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation

protocol MainPresenterProtocol {
    var router: MainRouterProtocol? {get set}
    var interactor: MainInteractorProtocol? {get set}
    var view: MainView? {get set}
    
    func didFetchMovies(with result: Result<[MovieMain], Error>)
}

class MainPresenter: MainPresenterProtocol {
    var router: MainRouterProtocol?
    
    var interactor: MainInteractorProtocol?
    
    var view: MainView?
    
    func didFetchMovies(with result: Result<[MovieMain], Error>) {
        
    }
    
    
}
