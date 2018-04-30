//
//  HomeTableViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 26/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import PKHUD

protocol HomeView: class {
    func showLoading();
    func hideLoading();
    func show(errorMsg: String)
    func load(movies: [Movie])
    func updateMovies(with movies: [Movie])
}

class HomeTableViewController: UITableViewController {

    var movies = [Movie]()
    var presenter: HomePresenter!
    
    let movieCellIdentifier = "movie_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPresenter()
        self.presenter.loadMovies()
        
        let cellNib = UINib(nibName: Constants.Cell.MOVIE_CELL, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: movieCellIdentifier)
    }
    
    func setupPresenter() {
        let genderRequester = GenderRequesterImpl()
        let movieRequester = MovieRequesterImpl()
        let movieDataSource = MovieDataSourceImpl(movieRequester: movieRequester, genderRequester: genderRequester)
        self.presenter = HomePresenterImpl(view: self, movieDataSouce: movieDataSource)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        cell.setup(with: movies[indexPath.row])
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if !HUD.isVisible {
                presenter.loadNextPage()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        performSegue(withIdentifier: Constants.Segue.SHOW_MOVIE_DETAILS, sender: cell)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? MovieTableViewCell,
            let destinationVC = segue.destination as? MovieDetailsViewController {
            
            destinationVC.movie = sender.movie
        }
    }

}

extension HomeTableViewController: HomeView {
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide(animated: true)
    }
    
    func show(errorMsg: String) {
        HUD.show(.labeledError(title: errorMsg, subtitle: nil))
    }
    
    func load(movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
    
    func updateMovies(with movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        self.tableView.reloadData()
    }
}
