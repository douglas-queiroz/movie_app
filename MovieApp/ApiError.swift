//
//  ApiError.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit


class APIError: NSError {
    
    var digipostErrorCode : String?
    var httpStatusCode : Int = 0
    var responseText : String?
    
    init(error: NSError) {
        super.init(domain: error.domain, code: error.code, userInfo: error.userInfo)
    }
    
    init(message: String, code: Int) {
        super.init(domain: domain, code: code, userInfo: nil)
    }
    
    override init(domain: String, code: Int, userInfo dict: [String : Any]? = nil) {
        super.init(domain: domain, code: code, userInfo: dict)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
