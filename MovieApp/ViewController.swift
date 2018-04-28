//
//  ViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieDataSouce = MovieDataSource(movieRequester: MovieRequesterImpl(),
                                             genderRequester: GenderRequesterImpl())
        
        movieDataSouce.getUpComing().subscribe { (event) in
            print("passou aqui")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

