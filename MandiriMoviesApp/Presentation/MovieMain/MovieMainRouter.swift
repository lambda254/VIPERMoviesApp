//
//  Router.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MovieMainRouterProtocol {
    var entry: MovieMainController? { get }
    static func start() -> MovieMainRouter
    
    func navigateToDetail(id: Int, title: String, poster: UIImage)
}

class MovieMainRouter: MovieMainRouterProtocol {
    var entry: MovieMainController?

    static func start() -> MovieMainRouter {
        let router = MovieMainRouter()
        
        let view = MovieMainController()
        let presenter = MovieMainPresenter()
        let interactor = MovieMainInteractor()
        
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
    
    func navigateToDetail(id: Int, title: String, poster: UIImage) {
        let nextRouter = MovieDetailRouter.start()
        guard let vc = nextRouter.entry else { return }
        vc.presenter?.didPassedMovieData(id: id, title: title, posterImage: poster)
        
        let navigationVc = UINavigationController(rootViewController: vc)
        navigationVc.modalPresentationStyle = .overFullScreen
        entry?.present(navigationVc, animated: true)
    }
    
}
