//
//  MovieTrailer.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/11/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit

class MovieTrailer{
    var movieID : Int
    var YouTubeKey : String?
    
    let part1URL = "https://api.themoviedb.org/3/movie/"
    let part2URL = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    //part1 + movieID + part2 = full URL for request

    init(movieID : Int){
        self.movieID = movieID
    }
    
    func fetchMovieTrailers(){
        let url = URL(string: part1URL + String(movieID) + part2URL)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){
            (data, response, error) in
            
            if let error = error{
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let videoDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                for video in videoDictionaries{
                    let videoType = video["type"] as! String
                    
                    if videoType == "Trailer"{
                        let videoKey = video["key"] as! String
                        self.YouTubeKey = videoKey
                        print(self.YouTubeKey)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
}
