//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 28/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {

    var movie: Movie!
    
    @IBOutlet weak var imgMovieBackDrop: UIImageView!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTile: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieGenders: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        navigationController?.title = movie.title
        
        imgMoviePoster.loadImage(from: movie.posterPath)
        imgMovieBackDrop.loadImage(from: movie.backdropPath)
        lblMovieTile.text = movie.title
        
        if let release = movie.releaseDate {
            lblMovieReleaseDate.text = String(format: Constants.StringFormat.RELEASE_DATE_FORMAT, release)
        }
        
        var txtGender = "| "
        if let genders = movie.genders {
            genders.forEach { (gender) in
                if let genderName = gender.name {
                    txtGender += "\(genderName) | "
                }
            }
        }
        
        lblMovieGenders.text = txtGender
        lblMovieOverview.text = movie.overview
        
    }

}
