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
    
//    override func loadView() {
//        let webConfig = WKWebViewConfiguration()
//        webConfig.allowsInlineMediaPlayback = true
//        trailerView = WKWebView(frame: .zero, configuration: webConfig)
//        
//        view = trailerView
//        
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerView.uiDelegate = self
        let myURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
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
    
    

}
