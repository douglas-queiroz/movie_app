//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieResponse: NSObject, Mappable {
    
    var movies: [Movie]?
    var page: Int?
    var totalPages: Int?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        movies <- map[Constants.MovieResponse.FIELD_MOVIES]
        page <- map[Constants.MovieResponse.FIELD_PAGE]
        totalPages <- map[Constants.MovieResponse.FIELD_TOTAL_PAGES]
    }
}
