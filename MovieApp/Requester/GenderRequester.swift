//
//  GenderRequester.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import RxAlamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

protocol GenderRequesterInterface {
    
    func getAllGenders() -> Observable<GendersResponse>;
    
}

class GenderRequester {
    
    func getAllGenders() -> Observable<GendersResponse> {
        return request(RouterAPI.genders).map { (json) -> GendersResponse in
            guard let gendersResponse = Mapper<GendersResponse>().map(JSONObject: json) else {
                throw APIError(message: "ObjectMapper can't mapping", code: 422)
            }
            
            return gendersResponse
        }
    }
}
