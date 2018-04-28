//
//  HomeTableViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit

protocol HomeView {
    func showLoading();
    func hideLoading();
    func load(movies: [Movie])
}

class HomeTableViewController: UITableViewController {

    var movies = [Movie]()
    var presenter: HomePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPresenter()
        self.presenter.loadMovies()
    }
    
    func setupPresenter() {
        let genderRequester = GenderRequesterImpl()
        let movieRequester = MovieRequesterImpl()
        let movieDataSource = MovieDataSourceImpl(movieRequester: movieRequester, genderRequester: genderRequester)
        self.presenter = HomePresenterImpl(view: self, movieDataSouce: movieDataSource)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell", for: indexPath)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeTableViewController: HomeView {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func load(movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
}
