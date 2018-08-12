//
//  TrailerViewController.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/10/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var trailerView: WKWebView!
    var movie : Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trailerView.uiDelegate = self
        let baseURL = "https://www.youtube.com/watch?v="
        
        let myURL = URL(string: "dQw4w9WgXcQ")!
        let youtubeRequest = URLRequest(url: myURL)
        trailerView.load(youtubeRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissTrailer(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchVideos(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                
                let alertController = UIAlertController(title: "Cannot get video", message: "The internet connection appears to be off", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    self.fetchVideos()
                }
                
                alertController.addAction(tryAgain)
                self.present(alertController, animated: true)
                
                
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let movies = dataDictionary["results"] as! [[String : Any]]
                
            }
        }
        task.resume()
        
    }
    

}
