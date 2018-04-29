//
//  UIImageViewExtention.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 28/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(from strUrl: String?) {
        guard let strUrl = strUrl else { return }
        let url = URL(string: Configuration.URL_IMAGE_BASE + strUrl)
        self.sd_setImage(with: url, completed: nil)
    }
}
