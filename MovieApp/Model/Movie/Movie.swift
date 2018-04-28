//
//  Movie.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import ObjectMapper

class Movie: Mappable {
    
    var title: String?
    var posterPath: String?
    var genreIds: [Int]?
    var genders: [Gender]?
    var backdropPath: String?
    var releaseDate: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        posterPath <- map["poster_path"]
        genreIds <- map["genre_ids"]
        backdropPath <- map["backdrop_path"]
        releaseDate <- map["release_date"]
    }
}
