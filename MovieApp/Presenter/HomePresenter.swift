//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenter: class {
    func loadMovies()
    func loadNextPage()
}

class HomePresenterImpl: HomePresenter {
    
    weak var view: HomeView!
    var movieDataSouce: MovieDataSource!
    var lastMovieResponse: MovieResponse!
    
    init(view: HomeView, movieDataSouce: MovieDataSource) {
        self.view = view
        self.movieDataSouce = movieDataSouce
    }
    
    func loadMovies() {
        self.loadMovies(page: 1)
    }
    
    func loadNextPage() {
        if let page = lastMovieResponse.page,
            let totalPage = lastMovieResponse.totalPages,
            page < totalPage {
            
            let nextPage = page + 1
            self.loadMovies(page: nextPage)
        }
    }
    
    private func loadMovies(page: Int) {
        view.showLoading()
        
        _ = movieDataSouce.getUpComing(page: page)
            .subscribe { (event) in
                switch event {
                case .completed:
                    self.view.hideLoading()
                    break
                case .next(let moviesResponse):
                    
                    guard let movies = moviesResponse.movies else { return }
                    
                    self.lastMovieResponse = moviesResponse
                    
                    if let page = moviesResponse.page {
                        if page == 1 {
                            self.view.load(movies: movies)
                        }else {
                            self.view.updateMovies(with: movies)
                        }
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
