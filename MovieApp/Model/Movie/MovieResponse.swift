//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import ObjectMapper

class MovieResponse: Mappable {
    
    var movies: [Movie]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
    }
}
