//
//  View.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

protocol MovieMainViewProtocol: AnyObject {
    var presenter: MovieMainPresenter? {get set}
    func update(result: Result<[MovieMain], Error>)
    func update(title: String)
}
