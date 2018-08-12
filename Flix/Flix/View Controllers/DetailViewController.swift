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
    
    func setupViews(){
        if let movie = movie{
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
