//
//  GenreMainView.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol GenreMainViewProtocol {
    var presenter: GenreMainPresenter? {get set}
    
    func update(with genre: [GenreMain])
}
