//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenterInterface {
    func loadMovies()
}

class HomePresenter {
    
    var genderRequester: GenderRequesterInterface!
    
    init(genderRequester: GenderRequesterInterface) {
        self.genderRequester = genderRequester
    }
    
    private func loadGenders() {
        genderRequester.getAllGenders()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (gendersResponse: GendersResponse) in
                
            }, onError: { (error: Error) in
                
            }, onCompleted: {
                
            }) {
                
        }
    }
}

extension HomePresenter: HomePresenterInterface {
    func loadMovies() {
        
    }
}
