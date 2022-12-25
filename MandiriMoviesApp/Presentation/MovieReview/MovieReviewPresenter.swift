//
//  MovieReviewPresenter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import UIKit

protocol MovieReviewPresenterProtocol: AnyObject {
    var router: MovieReviewRouter? {get set}
    var interactor: MovieReviewInteractorProtocol? {get set}
    var view: MovieReviewViewProtocol? {get set}
    
    func didPassedMovieId(movieId: Int)
    func didFetchedReview(reviewData: [MovieReview], totalData: Int)
    
    func fetchNewReviews()
        
    func dismissView()
}

class MovieReviewPresenter: MovieReviewPresenterProtocol {
    var router: MovieReviewRouter?
    
    var interactor: MovieReviewInteractorProtocol?
    
    weak var view: MovieReviewViewProtocol?
    
    var movieId: Int?
    
    deinit {
        print("presenter deinit")
    }

    func dismissView() {
        router?.dismissView()
    }
    
    func didPassedMovieId(movieId: Int) {
        self.movieId = movieId
        fetchNewReviews()
    }
    
    func didFetchedReview(reviewData: [MovieReview], totalData: Int) {
        view?.update(with: reviewData, totalReviewer: totalData)
    }
    
    func fetchNewReviews() {
        interactor?.getReviewData(movieId: movieId ?? 0)
    }
    
}
