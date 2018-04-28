//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 27/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import RxSwift

protocol MovieDataSource {
    func getUpComing() -> Observable<[Movie]>
}

class MovieDataSourceImpl: MovieDataSource {
    
    var movieRequester: MovieRequester!
    var genderRequester: GenderRequester!
    
    init(movieRequester: MovieRequester,
         genderRequester: GenderRequester) {
        
        self.movieRequester = movieRequester
        self.genderRequester = genderRequester
        
    }
    
    func getUpComing() -> Observable<[Movie]> {
        
        var genders: [Gender]?
        
        return self.genderRequester.getAllGenders()
            .flatMap({ (genderResponse) -> Observable<MovieResponse> in
                genders = genderResponse.genders
                return self.movieRequester.getUpComing()
            }).flatMap({ (movieResponse) -> Observable<[Movie]> in
                return self.load(genders: genders, on: movieResponse.movies)
            })
    }
    
    private func load(genders: [Gender]?, on movies: [Movie]?) -> Observable<[Movie]>{
        return Observable.create{ (observable) in
            guard let genders = genders else {
                // TODO: Improve it
                observable.onNext([Movie]())
                return Disposables.create()
            }
            
            guard let movies = movies else {
                observable.onNext([Movie]())
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
            
            observable.onNext(movies)
            
            return Disposables.create()
        }
    }
}
