//
//  Movie.swift
//  Flix
//
//  Created by Dhriti Chawla on 2/9/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    var baseUrl: String
    var posterPath: String
    var relDate: String
    var backdrop: String
    var backdropUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        posterPath = dictionary["poster_path"] as! String
        baseUrl = "https://image.tmdb.org/t/p/w500"
        posterUrl = URL (string: baseUrl + posterPath)
        overview = dictionary["overview"] as! String
        relDate = dictionary["release_date"] as! String
        backdrop = dictionary["backdrop_path"] as! String
        backdropUrl = URL(string: baseUrl + backdrop)
        
        
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

