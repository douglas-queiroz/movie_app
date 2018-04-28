//
//  RouterAPI.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Alamofire

enum RouterAPI: URLRequestConvertible {
    
    case movieUpComing
    case genders
    case seachMovie(query: String)
    
    static let baseURL = Configuration.URL_BASE
    
    var endPoint : String {
        switch self {
        case .movieUpComing: return "/movie/upcoming"
        case .genders: return "/genre/movie/list"
        case .seachMovie: return "/search/movie"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .movieUpComing: return .get
        case .genders: return .get
        case .seachMovie: return .get
        }
    }
    
    var params: [String: Any] {
        var params = ["api_key": Configuration.KEY as Any]
        
        switch self {
        case .seachMovie(let query):
            params["query"] = query
            return params
        default:
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RouterAPI.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(endPoint))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        
        return urlRequest
    }
    
    
}
