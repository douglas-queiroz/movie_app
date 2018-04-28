//
//  StringExtention.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 28/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFomarter = DateFormatter()
        dateFomarter.dateFormat = "yyyy-MM-dd"
        
        return dateFomarter.date(from: self)
    }
}
