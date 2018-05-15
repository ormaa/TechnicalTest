//
//  DetailsViewModel.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation


class DetailsViewModel {
    
    var searchedText = ""
    var moviesItem: MovieItem? = nil
    

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
