//
//  MovieDetailRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    var entry: MovieDetailPoint? { get }
    static func start() -> MovieDetailRouter
    
    func dismissView()
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    var entry: MovieDetailPoint?

    static func start() -> MovieDetailRouter {
        let router = MovieDetailRouter()
        
        var view: MovieDetailViewProtocol = MovieDetailController()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? MovieDetailPoint
        
        return router
    }
    
    func dismissView() {
        entry?.dismiss(animated: true)
    }
}
