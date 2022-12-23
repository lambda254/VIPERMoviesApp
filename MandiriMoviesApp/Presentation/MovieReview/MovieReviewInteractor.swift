//
//  MovieReviewInteractor.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 23/12/22.
//

import Foundation
import Moya
import SwiftyJSON
import UIKit

protocol MovieReviewInteractorProtocol {
    var presenter: MovieReviewPresenter? {get set}

}

class MovieReviewInteractor: MovieReviewInteractorProtocol {
    var presenter: MovieReviewPresenter?
    
    private var networkProvider = MoyaProvider<NetworkService>()
    
    
}
