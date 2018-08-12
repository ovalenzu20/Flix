//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/9/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var movies: [Movie] = []
    @IBOutlet weak var tableView: UITableView!
    var refreshControl : UIRefreshControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.movies[indexPath.row]
        movieCell.movie = movie
        movieCell.setupViews()
        
        return movieCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 245
        tableView.dataSource = self
        tableView.estimatedRowHeight = 245
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        fetchMovies()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
        
    }
    
    @objc func didPullToRefresh(_ refreshControl : UIRefreshControl){
        fetchMovies()
    }

    func fetchMovies(){
        activityIndicatorView.startAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
        activityIndicatorView.stopAnimating()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
