//
//  MovieReviewPresenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import UIKit

protocol MovieReviewPresenterProtocol {
    var router: MovieReviewRouter? {get set}
    var interactor: MovieReviewInteractorProtocol? {get set}
    var view: MovieReviewViewProtocol? {get set}
        
    func dismissView()
}

class MovieReviewPresenter: MovieReviewPresenterProtocol {
    var router: MovieReviewRouter?
    
    var interactor: MovieReviewInteractorProtocol?
    
    var view: MovieReviewViewProtocol?

    func dismissView() {
        router?.dismissView()
    }
    
}
