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
    
}

class GenreMainPresenter: GenreMainPresenterProtocol {
    var router: GenreMainRouter?
    
    var interactor: GenreMainInteractorProtocol? {
        didSet {
            interactor?.getGenreMovie(completion: {[unowned self] data in
                view?.update(with: data)
            })
        }
    }
    
    var view: GenreMainViewProtocol?
    
    func navigateToMovieMain(genreId: Int, title: String) {
        router?.navigateToMovieMain(genreId: genreId, title: title)
    }
}
