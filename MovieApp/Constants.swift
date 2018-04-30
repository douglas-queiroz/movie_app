//
//  Constants.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 29/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation

class Constants {
    class ApiParamsKey {
        static let API_KEY = "api_key"
        static let QUERY = "query"
        static let PAGE = "page"
    }
    
    class MovieResponse {
        static let FIELD_PAGE = "page"
        static let FIELD_TOTAL_PAGES = "total_pages"
        static let FIELD_MOVIES = "results"
    }
    
    class Movie {
        static let FIELD_TITLE = "title"
        static let FIELD_POSTER_PATH = "poster_path"
        static let FIELD_GENDER_IDS = "genre_ids"
        static let FIELD_BACKDROP_PATH = "backdrop_path"
        static let FIELD_RELEASE_DATE = "release_date"
        static let FIELD_OVERVIEW = "overview"
    }
    
    class GendersResponse {
        static let FIELD_GENDERS = "genres"
    }
    
    class Gender {
        static let FIELD_ID = "id"
        static let FIELD_NAME = "name"
    }
    
    class Cell {
        static let MOVIE_CELL = "MovieTableViewCell"
    }
    
    class Segue {
        static let SHOW_MOVIE_DETAILS = "sg_show_details"
    }
    
    class StringFormat {
        static let RELEASE_DATE_FORMAT = "Release: %@"
    }
}
