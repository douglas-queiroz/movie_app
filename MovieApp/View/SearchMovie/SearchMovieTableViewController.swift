//
//  SearchMovieTableViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 29/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import PKHUD

protocol SearchMovieView {
    func showLoading();
    func hideLoading();
    func show(errorMsg: String)
    func load(movies: [Movie])
    func updateMovies(with movies: [Movie])
}

class SearchMovieTableViewController: UITableViewController {

    var movies = [Movie]()
    let searchBar = UISearchBar()
    
    var presenter: SearchMoviePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSearchBar()
    }
    
    func setupPresenter() {
        let genderRequester = GenderRequesterImpl()
        let movieRequester = MovieRequesterImpl()
        let movieDataSource = MovieDataSourceImpl(movieRequester: movieRequester, genderRequester: genderRequester)
        self.presenter = SearchMoviePresenterImpl(view: self, movieDataSouce: movieDataSource)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView = searchBar
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell", for: indexPath) as! HomeTableViewCell
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? HomeTableViewCell,
            let destinationVC = segue.destination as? MovieDetailsViewController {
            
            destinationVC.movie = sender.movie
        }
    }

}

extension SearchMovieTableViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = .done
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchMovieTableViewController: SearchMovieView {
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
