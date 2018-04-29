//
//  RouterAPI.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Alamofire

enum RouterAPI: URLRequestConvertible {
    
    case movieUpComing(page: Int)
    case genders
    case seachMovie(query: String, page: Int)
    
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
        case .movieUpComing(let page):
            params["page"] = page
            return params
        case .seachMovie(let query, let page):
            params["query"] = query
            params["page"] = page
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
