//
//  SearchMovieTableViewController.swift
//  MovieApp
//
//  Created by Douglas Queiroz on 29/04/18.
//  Copyright © 2018 Douglas Queiroz. All rights reserved.
//

import UIKit
import PKHUD
import RxSwift
import RxCocoa

protocol SearchMovieView: class {
    func showLoading();
    func hideLoading();
    func show(errorMsg: String)
    func load(movies: [Movie])
    func updateMovies(with movies: [Movie])
}

class SearchMovieTableViewController: UITableViewController {

    var movies = [Movie]()
    let searchBar = UISearchBar()
    let movieCellIdentifier = "movie_cell"
    
    var presenter: SearchMoviePresenter!
    var searchBarDisposable: Disposable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: Constants.Cell.MOVIE_CELL, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: movieCellIdentifier)
        
        self.setupPresenter()
        self.setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
        self.searchBarDisposable = searchBar.rx.text.orEmpty
            .throttle(2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                switch event {
                case .next(let query):
                    self.presenter.loadMovies(with: query)
                    break
                default:
                    return
                }
        }
    }
    
    func setupPresenter() {
        let genderRequester = GenderRequesterImpl()
        let movieRequester = MovieRequesterImpl()
        let movieDataSource = MovieDataSourceImpl(movieRequester: movieRequester, genderRequester: genderRequester)
        self.presenter = SearchMoviePresenterImpl(view: self, movieDataSouce: movieDataSource)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBarDisposable.dispose()
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
            if !HUD.isVisible && !movies.isEmpty {
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
