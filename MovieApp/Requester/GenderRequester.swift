//
//  GenderRequester.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class GenderRequester {
    
    typealias GendersResult = (_ genders:GendersResponse?, _ error:Error?) -> Void
    
    func getAllGenders(completion:@escaping GendersResult) {
        request(RouterAPI.genders).responseObject { (response: DataResponse<GendersResponse>) in
            switch response.result {
            case .success(let genders):
                completion(genders, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
