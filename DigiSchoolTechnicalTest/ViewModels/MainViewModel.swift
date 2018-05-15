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
        
            if error != "" {
                // web service returned an error
                completion( Errors.LoadingError + error + " '" )
            }
            else {
                // json received
                
                if data != nil {
                    
                    // Vérify if web site has returned a json object containing an error message
                    let jsonError = MovieItemParser().getJSONError(datas: data!)
                    if jsonError != "" {
                        completion( Errors.JSONError + jsonError + " '" )
                    }
                    else {
                        // Parse json object, to get list of movies
                        let (items, parseError) = MovieItemParser().jsonDecode(datas: data!)
                        if parseError == "" {
                            self.moviesItems = items
                            
                            completion("")
                        }
                        else {
                            completion ( Errors.JSONError + error + " '" )
                        }
                    }
                }
            }
        })
        
        
        
    }
    
}
