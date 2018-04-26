//
//  RouterAPI.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Alamofire

enum RouterAPI: URLRequestConvertible {
    
    case list
    case genders
    case movie(movieId: String)
    
    static let baseURL = Configuration.URL_BASE
    
    var endPoint : String {
        switch self {
        case .list: return ""
        case .genders: return "/genre/movie/list"
        case .movie: return ""
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .list: return .get
        case .genders: return .get
        case .movie: return .get
        }
    }
    
    var params: [String: Any] {
        return ["api_key": Configuration.KEY as Any]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RouterAPI.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(endPoint))
        urlRequest.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        
        return urlRequest
    }
    
    
}
