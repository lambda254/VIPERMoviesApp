//
//  View.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MovieMainViewProtocol {
    var presenter: MovieMainPresenter? {get set}
    func update(with movies: [MovieMain])
    func update(title: String)
}
