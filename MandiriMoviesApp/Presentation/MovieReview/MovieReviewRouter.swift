//
//  MovieReviewRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol MovieReviewRouterProtocol {
    var entry: MovieReviewPoint? { get }
    static func start() -> MovieReviewRouter
    
    func dismissView()
}

class MovieReviewRouter: MovieReviewRouterProtocol {
    var entry: MovieReviewPoint?

    static func start() -> MovieReviewRouter {
        let router = MovieReviewRouter()
        
        var view: MovieReviewViewProtocol = MovieReviewController()
        let presenter = MovieReviewPresenter()
        let interactor = MovieReviewInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? MovieReviewPoint
        
        return router
    }
    
    func dismissView() {
        entry?.dismiss(animated: true)
    }
}
