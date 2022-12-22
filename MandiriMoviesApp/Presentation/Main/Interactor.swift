//
//  Interactor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation

protocol MainInteractorProtocol {
    var presenter: MainPresenter? {get set}
    
    func getMovies()
}

class MainInteractor: MainInteractorProtocol {
    var presenter: MainPresenter?
    
    func getMovies() {
        
    }
    
    
}
