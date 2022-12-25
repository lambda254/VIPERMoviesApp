//
//  MovieReviewRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol MovieReviewRouterProtocol {
    var entry: MovieReviewController? { get }
    static func start() -> MovieReviewRouter
    
    func dismissView()
}

class MovieReviewRouter: MovieReviewRouterProtocol {
    var entry: MovieReviewController?

    static func start() -> MovieReviewRouter {
        let router = MovieReviewRouter()
        
        var view = MovieReviewController()
        let presenter = MovieReviewPresenter()
        let interactor = MovieReviewInteractor()

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
}
