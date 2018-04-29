//
//  HomeTableViewCell.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 28/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    var movie: Movie!
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReleseDate: UILabel!
    @IBOutlet weak var lblMovieGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with movie: Movie) {
        self.movie = movie
        
        if let posterPath = movie.posterPath {
            let url = URL(string: Configuration.URL_IMAGE_BASE + posterPath)
            imgMoviePoster.sd_setImage(with: url, completed: nil)
        }
        
        lblMovieTitle.text = movie.title
        
        if let release = movie.releaseDate {
            lblMovieReleseDate.text = String(format: "Release: %@", release)
        }
        
        var txtGender = "| "
        if let genders = movie.genders {
            genders.forEach { (gender) in
                if let genderName = gender.name {
                    txtGender += "\(genderName) | "
                }
            }
        }
        
        lblMovieGender.text = txtGender
    }

}
