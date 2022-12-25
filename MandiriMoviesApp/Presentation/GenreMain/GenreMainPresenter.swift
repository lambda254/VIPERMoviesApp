//
//  GenreMainPresenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import UIKit

protocol GenreMainPresenterProtocol {
    var router: GenreMainRouter? {get set}
    var interactor: GenreMainInteractorProtocol? {get set}
    var view: GenreMainViewProtocol? {get set}
    
    func navigateToMovieMain(genreId: Int, title: String)
    
    func didFetchedGenre(data: [GenreMain])
    
}

class GenreMainPresenter: GenreMainPresenterProtocol {
    var router: GenreMainRouter?
    
    var interactor: GenreMainInteractorProtocol? {
        didSet {
            interactor?.getGenreMovie()
        }
    }
    
    var view: GenreMainViewProtocol?
    
    func didFetchedGenre(data: [GenreMain]) {
        view?.update(with: data)
    }
    
    func navigateToMovieMain(genreId: Int, title: String) {
        router?.navigateToMovieMain(genreId: genreId, title: title)
    }
}
