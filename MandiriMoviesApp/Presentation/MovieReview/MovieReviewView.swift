//
//  MovieReviewView.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MovieReviewViewProtocol {
    var presenter: MovieReviewPresenter? {get set}
    func update(with Review: MovieReview)
    func update(title: String, posterImage: UIImage)
    func update(trailer: String)
}

