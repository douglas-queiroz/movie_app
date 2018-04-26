//
//  ViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 24/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let genderRequester = GenderRequester()
        genderRequester.getAllGenders { (genders, error) in
            print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

