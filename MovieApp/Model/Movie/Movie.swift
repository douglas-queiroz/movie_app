//
//  Movie.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: NSObject, Mappable {
    
    var title: String?
    var posterPath: String?
    var genreIds: [Int]?
    var genders: [Gender]?
    var backdropPath: String?
    var releaseDate: String?
    var overview: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map[Constants.Movie.FIELD_TITLE]
        posterPath <- map[Constants.Movie.FIELD_POSTER_PATH]
        genreIds <- map[Constants.Movie.FIELD_GENDER_IDS]
        backdropPath <- map[Constants.Movie.FIELD_BACKDROP_PATH]
        releaseDate <- map[Constants.Movie.FIELD_RELEASE_DATE]
        overview <- map[Constants.Movie.FIELD_OVERVIEW]
    }
}
