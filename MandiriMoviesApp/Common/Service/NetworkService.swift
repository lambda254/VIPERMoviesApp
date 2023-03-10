//
//  NetworkService.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import Moya
import Alamofire

enum NetworkService {
    case fetchAllMovieTitle(page: Int, genreId: Int)
    case fetchAllMoviePoster(image: String)
    case fetchDetailData(movieId: Int)
    case fetchReviewData(movieId: Int, page: Int)
    case fetchTrailerData(movieId: Int)
    case fetchGenreData
}

extension NetworkService: TargetType {
    
    var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    
    var baseURL: URL {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchTrailerData, .fetchGenreData:
            return URL(string: "https://api.themoviedb.org") ?? self.baseURL
        case .fetchAllMoviePoster:
            return URL(string: "https://image.tmdb.org") ?? self.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .fetchAllMovieTitle:
            return "/3/discover/movie"
        case .fetchAllMoviePoster(let imageString):
            return "/t/p/w500\(imageString)"
        case .fetchDetailData(let movieId):
            return "/3/movie/\(movieId)"
        case .fetchReviewData(let movieId, _):
            return "/3/movie/\(movieId)/reviews"
        case .fetchTrailerData(let movieId):
            return "/3/movie/\(movieId)/videos"
        case .fetchGenreData:
            return "/3/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchAllMoviePoster, .fetchTrailerData, .fetchGenreData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAllMovieTitle(let page, let genreId):
            return .requestParameters(parameters: ["api_key" : apiKey, "with_genres" : genreId , "sort_by" : "popularity.desc", "include_adult" : "false", "include_video" : "true", "page" : page], encoding: URLEncoding.queryString)
        case .fetchAllMoviePoster:
            return .requestPlain
        case .fetchDetailData, .fetchTrailerData, .fetchGenreData:
            return .requestParameters(parameters: ["api_key" : apiKey], encoding: URLEncoding.queryString)
        case .fetchReviewData(_, let page):
            return .requestParameters(parameters: ["api_key" : apiKey, "page" : page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchTrailerData, .fetchGenreData:
            return ["Content-Type" : "application/json"]
        case .fetchAllMoviePoster:
            return ["Content-Type" : "image/jpeg"]
        }
    }
}
