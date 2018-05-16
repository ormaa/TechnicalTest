//
//  Models.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 16/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation


class JSONError: Codable {
    var Response = ""
    var Error = ""
}

/// List of movies

class MovieArray: Codable {
    var search = [MovieItem]()
    var total = ""
    var response = ""
    
    // define how to map value between class and json text
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
        case total = "totalResults"
        case response = "Response"
    }
}


class MovieItem: Codable {
    
    var id: String = ""
    var title: String = ""
    
    // define how to map value between class and json text
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case id = "imdbID"
    }
    
}


/// detail of a movie

class MovieDetailsItem: Codable {
    
    var title: String = ""
    var poster: String? = ""
    var releaseDate: String = ""
    var imdbRating: String = ""
    var audience: String = ""
    var synopsis: String = ""
    var casting: String = ""
    var similarMovies: String = ""
    var Ratings: [Ratings] = []
    
    // define how to map value between class and json text
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case releaseDate = "Released"
        case imdbRating = "imdbRating"
        case audience = "imdbVotes"
        case synopsis = "Plot"
        case casting = "Actors"
        case similarMovies = "Genre"
    }
}

class Ratings: Codable {
    var Source: String = ""
    var Value: String = ""
}


