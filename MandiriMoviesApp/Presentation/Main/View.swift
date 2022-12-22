//
//  View.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MainViewProtocol {
    var presenter: MainPresenterProtocol? {get set}
    func update(with movies: [MovieMain])
    func update(with errors: String)
}

class MainView: ASDKViewController<ASScrollNode> {
    
}

extension MainView: MainViewProtocol {
    
}