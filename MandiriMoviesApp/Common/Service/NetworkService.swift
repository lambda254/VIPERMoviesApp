//
//  NetworkService.swift
//  MandiriMoviesApp
//
//  Created by Reza Mac on 22/12/22.
//

import Foundation
import Moya

enum NetworkService {
    case fetchAllMovieTitle(page: Int)
    case fetchAllMoviePoster(image: String)
    case fetchDetailData(movieId: Int)
    case fetchReviewData(movieId: Int, page: Int)
    case fetchTrailerData(movieId: Int)
}

extension NetworkService: TargetType {
    
    var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    
    var baseURL: URL {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchTrailerData:
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchAllMoviePoster, .fetchTrailerData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAllMovieTitle(let page):
            return .requestParameters(parameters: ["api_key" : apiKey, "sort_by" : "popularity.desc", "include_adult" : "false", "include_video" : "true", "page" : page], encoding: URLEncoding.queryString)
        case .fetchAllMoviePoster:
            return .requestPlain
        case .fetchDetailData, .fetchTrailerData:
            return .requestParameters(parameters: ["api_key" : apiKey], encoding: URLEncoding.queryString)
        case .fetchReviewData(_, let page):
            return .requestParameters(parameters: ["api_key" : apiKey, "" : 1], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchAllMovieTitle, .fetchDetailData, .fetchReviewData, .fetchTrailerData:
            return ["Content-Type" : "application/json"]
        case .fetchAllMoviePoster:
            return ["Content-Type" : "image/jpeg"]
        }
    }
}
