//
//  SearchMoviePresenter.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 29/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation

protocol SearchMoviePresenter {
    func loadMovies(with query: String)
    func loadNextPage()
}

class SearchMoviePresenterImpl: SearchMoviePresenter {
    
    func loadMovies(with query: String) {
        
    }
    
    func loadNextPage() {
        
    }
}
