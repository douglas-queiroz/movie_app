//
//  GenderRequester.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import RxSwift

protocol GenderRequester {
    func getAllGenders() -> Observable<GendersResponse>;
}

class GenderRequesterImpl: GenderRequester {
    
    func getAllGenders() -> Observable<GendersResponse> {
        return Observable.create { observer in
            request(RouterAPI.genders)
                .responseObject { (response:DataResponse<GendersResponse>) in
                    switch response.result {
                    case .success(let genders):
                        observer.onNext(genders)
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
