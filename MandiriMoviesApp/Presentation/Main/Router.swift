//
//  Router.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

typealias EntryPoint = MainViewProtocol & ASDKViewController<ASScrollNode>

protocol MainRouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> MainRouter
}

class MainRouter: MainRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> MainRouter {
        let router = MainRouter()
        
        var view: MainViewProtocol = MainViewController()
        var presenter: MainPresenter = MainPresenter()
        var interactor: MainInteractor = MainInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
