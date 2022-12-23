//
//  Router.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport



protocol MovieMainRouterProtocol {
    var entry: MovieMainPoint? { get }
    static func start() -> MovieMainRouter
    
    func navigateToDetail(id: Int, title: String, poster: UIImage)
}

class MovieMainRouter: MovieMainRouterProtocol {
    var entry: MovieMainPoint?

    static func start() -> MovieMainRouter {
        let router = MovieMainRouter()
        
        var view: MovieMainViewProtocol = MovieMainController()
        let presenter = MovieMainPresenter()
        let interactor = MovieMainInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? MovieMainPoint
        
        return router
    }
    
    func navigateToDetail(id: Int, title: String, poster: UIImage) {
        let nextRouter = MovieDetailRouter.start()
        guard let vc = nextRouter.entry else { return }
        vc.presenter?.didPassedMovieData(id: id, title: title, posterImage: poster)
        vc.modalPresentationStyle = .overFullScreen
        entry?.present(vc, animated: true)
    }
    
}
