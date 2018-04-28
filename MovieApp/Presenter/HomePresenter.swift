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
    func loadNextPage()
}

class HomePresenterImpl: HomePresenter {
    
    var view: HomeView!
    var movieDataSouce: MovieDataSource!
    var currentPage = 1
    
    init(view: HomeView, movieDataSouce: MovieDataSource) {
        self.view = view
        self.movieDataSouce = movieDataSouce
    }
    
    func loadMovies() {
        currentPage = 1
        self.loadMovies(page: currentPage)
    }
    
    func loadNextPage() {
        currentPage += 1
        self.loadMovies(page: currentPage)
    }
    
    private func loadMovies(page: Int) {
        view.showLoading()
        
        _ = movieDataSouce.getUpComing(page: currentPage)
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
