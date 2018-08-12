//
//  Movie.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/11/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var releaseDate : String
    var overview : String
    var id : Int
    var posterURL : URL!
    var backdropURL : URL!
    
    let baseURL = "https://image.tmdb.org/t/p/w500"
    let baseBackdropURLString = "https://image.tmdb.org/t/p/original"
    

    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        overview = dictionary["overview"] as? String ?? "No overview"
        id = dictionary["id"] as? Int ?? -1
        
        let posterURLString = dictionary["poster_path"] as! String
        posterURL = URL(string: baseURL + posterURLString)!
        
        let backdropURLString = dictionary["backdrop_path"] as! String
        backdropURL = URL(string: baseBackdropURLString + backdropURLString)!
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
}
