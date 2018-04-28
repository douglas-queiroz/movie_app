//
//  DateExtention.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 28/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import Foundation

extension Date {
    
    func toLocaleFormat() -> String? {
        let dateFomarter = DateFormatter()
        dateFomarter.locale = Locale.current
        
        return dateFomarter.string(from: self)
    }
}
