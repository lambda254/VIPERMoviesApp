//
//  GenreMainRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol GenreMainRouterProtocol {
    var entry: GenreMainPoint? { get }
    static func start() -> GenreMainRouter
    
    func navigateToMovieMain(genreId: Int, title: String)
    
    func dismissView()
}

class GenreMainRouter: GenreMainRouterProtocol {
    var entry: GenreMainPoint?

    static func start() -> GenreMainRouter {
        let router = GenreMainRouter()
        
        var view: GenreMainViewProtocol = GenreMainController()
        let presenter = GenreMainPresenter()
        let interactor = GenreMainInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? GenreMainPoint
        
        return router
    }
    
    func dismissView() {
        entry?.dismiss(animated: true)
    }
    
    func navigateToMovieMain(genreId: Int, title: String) {
        let nextRouter = MovieMainRouter.start()
        guard let vc = nextRouter.entry else { return }
        vc.presenter?.didPassedGenreId(genreId: genreId, title: title)
        entry?.navigationController?.pushViewController(vc, animated: true)
    }
}
