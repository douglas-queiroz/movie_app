//
//  GendersResponse.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import ObjectMapper

class GendersResponse: Mappable {
    
    var genders: [Gender]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        genders <- map["genres"]
    }
}
