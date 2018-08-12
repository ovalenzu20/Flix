//
//  DetailViewController.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/10/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
   
    var movie : Movie?
    var movieTrailer : MovieTrailer?
    
    func setupViews(){
        if let movie = movie{
            movieTrailer = MovieTrailer(movieID: movie.id)
            backDropImageView.af_setImage(withURL: movie.backdropURL!)
            posterImageView.af_setImage(withURL: movie.posterURL!)
            titleLabel.text! = movie.title
            releaseDateLabel.text! = movie.releaseDate
            overviewLabel.text! = movie.overview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        movieTrailer = MovieTrailer(movieID: movie!.id)
        movieTrailer?.fetchMovieTrailers()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerVC = segue.destination as! TrailerViewController
        let baseYouTubeString = "https://www.youtube.com/watch?v="
        
        trailerVC.YouTubeURL = URL(string: baseYouTubeString + (movieTrailer?.YouTubeKey)!)!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
