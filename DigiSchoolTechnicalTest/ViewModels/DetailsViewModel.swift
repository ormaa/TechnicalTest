//
//  DetailsViewModel.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation


class DetailsViewModel {
    

    var moviesDetailsItem: MovieDetailsItem? = nil
    

    
    
    
    // get details of a movie from Webservices
    //
    func getMovieDetails(imdbID: String, completion:@escaping (_ error: String) -> Void) {
    
        // Get movie list using web service
        WebServices().getMovieDetails(imdbID: imdbID, completion: { (error, data) in
            guard error == "" else {
                // web service returned an error
                completion( Errors.LoadingError + error + " '" )
                return
            }
            // json received, no error reported
            guard data != nil  else {
                return
            }
    
            // check json object can be parsed
            let jsonError = MovieItemParser().getJSONError(datas: data!)
            guard jsonError == "" else {
                completion( Errors.JSONError + jsonError + " '" )
                return
            }
            // Parse json object, to get list of movies
            let (item, parseError) = MovieItemParser().jsonDecodeMovieDetail(datas: data!)
            if parseError == "" {
                self.moviesDetailsItem = item
                completion("")
            }
            else {
                completion ( Errors.JSONError + parseError + " '" )
            }
        })

    }
    
    
    
    // get an image from webservice
    //
    func getPosterImage(imageURLString: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        WebServices().downloadImage(url: imageURLString, completion: { (error, data) in
            guard error == "" else {
                completion(error, nil)
                return
            }
            // Some stuff could be done here...
            
            completion("", data)
        })
    }

    
}
