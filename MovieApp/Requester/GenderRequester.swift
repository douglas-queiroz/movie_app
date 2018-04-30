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

protocol GenderRequester: class {
    func getAllGenders() -> Observable<GendersResponse>;
}

class GenderRequesterImpl: GenderRequester {
    
    func getAllGenders() -> Observable<GendersResponse> {
        return Observable.create { observable in
            request(RouterAPI.genders)
                .responseObject { (response:DataResponse<GendersResponse>) in
                    switch response.result {
                    case .success(let genders):
                        observable.onNext(genders)
                        observable.onCompleted()
                        break
                    case .failure(let error):
                        observable.onError(error)
                        break
                    }
            }
            
            return Disposables.create()
        }
    }
}
