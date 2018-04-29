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
    
    var view: SearchMovieView!
    var movieDataSouce: MovieDataSource!
    var currentQuery: String!
    var currentPage = 1
    
    init(view: SearchMovieView, movieDataSouce: MovieDataSource) {
        self.view = view
        self.movieDataSouce = movieDataSouce
    }
    
    func loadMovies(with query: String) {
        if query.isEmpty {
            view.load(movies: [])
            return
        }
        
        currentPage = 1
        currentQuery = query
        loadMovies(query: query, page: currentPage)
    }
    
    func loadNextPage() {
        currentPage += 1
        loadMovies(query: currentQuery, page: currentPage)
    }
    
    private func loadMovies(query: String, page: Int) {
        view.showLoading()
        
        _ = movieDataSouce.search(query: query, page: page)
            .subscribe { (event) in
                switch event {
                case .completed:
                    self.view.hideLoading()
                    break
                case .next(let movies):
                    self.view.hideLoading()
                    if self.currentPage == 1 {
                        self.view.load(movies: movies)
                    }else {
                        self.view.updateMovies(with: movies)
                    }
                    break
                case .error(let erro):
                    self.view.hideLoading()
                    self.view.show(errorMsg: erro.localizedDescription)
                    break
                }
        }
    }
}
