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
    
    func update(result: Result<[GenreMain], Error>)
}

