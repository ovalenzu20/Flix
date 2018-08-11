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
    var movies : [[String : Any]] = []
    @IBOutlet weak var tableView: UITableView!
    var refreshControl : UIRefreshControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        let posterPath = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + posterPath)!

        cell.titleLabel.text! = title
        cell.overviewLabel.text! = overview
        cell.posterImage.af_setImage(withURL: posterURL)
        
        return cell
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
    
    @objc func didPullToRefresh(_ refreshControl : UIRefreshControl){
        fetchMovies()
    }

    func fetchMovies(){
        activityIndicatorView.startAnimating()

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                
                let alertController = UIAlertController(title: "Cannot get movies", message: "The internet connection appears to be off", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    self.fetchMovies()
                }
                alertController.addAction(tryAgain)
                self.present(alertController, animated: true)
                
                
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let movies = dataDictionary["results"] as! [[String : Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        activityIndicatorView.stopAnimating()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
