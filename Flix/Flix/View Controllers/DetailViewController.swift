//
//  DetailViewController.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/10/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit
import WebKit

enum MovieKeys{
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
   
    var movie : [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie[MovieKeys.backdropPath] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerVC = segue.destination as! TrailerViewController
        
        
    }
    
//    @IBAction func didTapPoster(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let userVC = mainStoryboard.instantiateViewController(withIdentifier: "TrailerViewController") as! TrailerViewController
//        performSegue(withIdentifier: "tappedPosterView", sender: nil)
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
