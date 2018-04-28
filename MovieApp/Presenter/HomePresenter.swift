//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenter {
    func loadMovies()
}

class HomePresenterImpl: HomePresenter {
    
    var view: HomeView!
    var movieDataSouce: MovieDataSource!
    
    init(view: HomeView, movieDataSouce: MovieDataSource) {
        self.view = view
        self.movieDataSouce = movieDataSouce
    }
    
    func loadMovies() {
        
        view.showLoading()
        
        _ = movieDataSouce.getUpComing().subscribe { (event) in
            switch event {
            case .completed:
                self.view.hideLoading()
                break
            case .next(let movies):
                self.view.load(movies: movies)
                break
            case .error(let erro):
                self.view.hideLoading()
                break
            }
        }
    }
}
