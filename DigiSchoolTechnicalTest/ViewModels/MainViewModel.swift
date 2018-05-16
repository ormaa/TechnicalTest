//
//  MainViewModel.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation


class MainViewModel {
    
    var searchedText = ""
    var moviesItems = [MovieItem]()
    
    
    func clearMovieItems() {
        moviesItems = []
    }
    
    
    // call web service to get a list of movie where the name contain filterName value
    //
    func getMoviesList(filterName: String, completion:@escaping (_ error: String) -> Void) {

        // Get movie list using web service
        WebServices().getMoviesList(searchPattern: filterName, completion: { (error, data) in
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
            let (items, parseError) = MovieItemParser().jsonDecodeMovieList(datas: data!)
            if parseError == "" {
                self.moviesItems = items
                
                completion("")
            }
            else {
                completion ( Errors.JSONError + parseError + " '" )
            }
        })
        
        
        
    }
    
}
