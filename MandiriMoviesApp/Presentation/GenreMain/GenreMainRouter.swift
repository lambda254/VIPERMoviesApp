//
//  GenreMainRouter.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import UIKit

protocol GenreMainRouterProtocol {
    var entry: GenreMainController? { get }
    static func start() -> GenreMainRouter
    
    func navigateToMovieMain(genreId: Int, title: String)
    
    func dismissView()
}

class GenreMainRouter: GenreMainRouterProtocol {
    var entry: GenreMainController?

    static func start() -> GenreMainRouter {
        let router = GenreMainRouter()
        
        let view = GenreMainController()
        let presenter = GenreMainPresenter()
        let interactor = GenreMainInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
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
