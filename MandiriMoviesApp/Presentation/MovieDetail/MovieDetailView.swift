//
//  MovieDetailView.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MovieDetailViewProtocol {
    var presenter: MovieDetailPresenter? {get set}
    func update(with detail: MovieDetail)
    func update(title: String, posterImage: UIImage)
    func update(trailer: String)
}

