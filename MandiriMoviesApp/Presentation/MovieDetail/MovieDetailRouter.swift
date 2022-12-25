//
//  MovieDetailRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    var entry: MovieDetailController? { get }
    static func start() -> MovieDetailRouter
    
    func navigateToReview(movieId: Int)
    
    func dismissView()
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    var entry: MovieDetailController?

    static func start() -> MovieDetailRouter {
        let router = MovieDetailRouter()
        
        let view = MovieDetailController()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    deinit {
        print("router deinit")
    }
    
    func dismissView() {
        entry?.dismiss(animated: true)
    }
    
    func navigateToReview(movieId: Int) {
        let nextRouter = MovieReviewRouter.start()
        guard let vc = nextRouter.entry else { return }
        vc.presenter?.didPassedMovieId(movieId: movieId)
        entry?.navigationController?.pushViewController(vc, animated: true)
    }
}
