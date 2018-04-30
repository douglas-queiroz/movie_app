//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import RxSwift

protocol MovieDataSource: class {
    func getUpComing(page: Int) -> Observable<MovieResponse>
    func search(query: String, page: Int) -> Observable<MovieResponse>
}

class MovieDataSourceImpl: MovieDataSource {
    
    var movieRequester: MovieRequester!
    var genderRequester: GenderRequester!
    
    init(movieRequester: MovieRequester,
         genderRequester: GenderRequester) {
        
        self.movieRequester = movieRequester
        self.genderRequester = genderRequester
        
    }
    
    func getUpComing(page: Int) -> Observable<MovieResponse> {
        
        var genders: [Gender]?
        
        return self.genderRequester.getAllGenders()
            .flatMap({ (genderResponse) -> Observable<MovieResponse> in
                genders = genderResponse.genders
                return self.movieRequester.getUpComing(page: page)
            }).flatMap({ (movieResponse) -> Observable<MovieResponse> in
                return self.load(genders: genders, on: movieResponse)
            })
    }
    
    func search(query: String, page: Int) -> Observable<MovieResponse> {
        
        var genders: [Gender]?
        
        return self.genderRequester.getAllGenders()
            .flatMap({ (genderResponse) -> Observable<MovieResponse> in
                genders = genderResponse.genders
                return self.movieRequester.search(query: query, page: page)
            }).flatMap({ (movieResponse) -> Observable<MovieResponse> in
                return self.load(genders: genders, on: movieResponse)
            })
    }
    
    private func load(genders: [Gender]?, on movieResponse: MovieResponse) -> Observable<MovieResponse>{
        return Observable.create{ (observable) in
            
            guard let genders = genders else {
                observable.onError(DataLoadError.emptyGenders)
                return Disposables.create()
            }
            
            guard let movies = movieResponse.movies else {
                observable.onError(DataLoadError.emptyMovies)
                return Disposables.create()
            }
            
            movies.forEach({ (movie) in
                if let genderIds = movie.genreIds {
                    movie.genders = [Gender]()
                    
                    genderIds.forEach({ (genderId) in
                        let result = genders.filter{$0.id == genderId}
                        movie.genders?.append(contentsOf: result)
                    })
                }
            })
            
            observable.onNext(movieResponse)
            observable.onCompleted()
            
            return Disposables.create()
        }
    }
}
