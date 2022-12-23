//
//  Alias.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import TextureSwiftSupport

typealias MovieMainPoint = MovieMainViewProtocol & ASDKViewController<ASScrollNode>
typealias MovieDetailPoint = MovieDetailViewProtocol & ASDKViewController<ASScrollNode>
typealias MovieReviewPoint = MovieReviewViewProtocol & ASDKViewController<ASScrollNode>
typealias GenreMainPoint = GenreMainViewProtocol & ASDKViewController<ASScrollNode>
