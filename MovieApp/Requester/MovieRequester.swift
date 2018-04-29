//
//  MovieRequester.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import RxSwift

protocol MovieRequester {
    func getUpComing(page: Int) -> Observable<MovieResponse>
    func search(query: String, page: Int) -> Observable<MovieResponse>
}

class MovieRequesterImpl: MovieRequester {
    
    func getUpComing(page: Int) -> Observable<MovieResponse> {
        return Observable.create { observer in
            request(RouterAPI.movieUpComing(page: page))
                .responseObject { (response:DataResponse<MovieResponse>) in
                    switch response.result {
                    case .success(let movies):
                        observer.onNext(movies)
                        break
                    case .failure(let error):
                        observer.onError(error)
                        break
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func search(query: String, page: Int) -> Observable<MovieResponse> {
        return Observable.create { observer in
            request(RouterAPI.seachMovie(query: query, page: page))
                .responseObject { (response:DataResponse<MovieResponse>) in
                    switch response.result {
                    case .success(let movies):
                        observer.onNext(movies)
                        break
                    case .failure(let error):
                        observer.onError(error)
                        break
                    }
            }
            
            return Disposables.create()
        }
    }
    
}
