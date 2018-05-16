//
//  WebServices.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//


import UIKit
import Foundation
import WebKit





class WebServices {
    
    //var url = "https://www.omdbapi.com/?i=tt3896198&apikey=9d307ea"
    
    // you need to add the movie name pattern at the end.
    var searchURLString = "http://www.omdbapi.com/?apikey=9d307ea&s="
    var detailsURLString = "http://www.omdbapi.com/?apikey=9d307ea&i="

    
    
    
    // Download an image from Internet
    //
    func downloadImage(url: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    completion(error.localizedDescription, nil)
                }
                return
            }
            completion("", data)
        }
        task.resume()
    }
    
    
    // call web service, allow to keep alive connection, even if ipad does nothing during long time
    func getMoviesList(searchPattern: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        
        let fullUrlString = searchURLString + searchPattern
        let urlString = fullUrlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        self.callWebService(urlString:  urlString!, completion: { (error, data) in
            completion(error, data)
        })
    }
    
    // call web service, allow to keep alive connection, even if ipad does nothing during long time
    func getMovieDetails(imdbID: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        
        let fullUrlString = detailsURLString + imdbID
        let urlString = fullUrlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        self.callWebService(urlString:  urlString!, completion: { (error, data) in
            completion(error, data)
        })
    }
    

    // common func called to call webservices
    //
    func callWebService(urlString: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        
        let url = NSURL(string: NSString(format: "%@", urlString)as String) as URL?
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(8)
        configuration.timeoutIntervalForResource = TimeInterval(8)
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        
        // request the data.
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            
            guard error == nil else {
                Tools.log("Web service error : " + urlString)
                Tools.log(error!.localizedDescription )
                completion("error : " + error!.localizedDescription, nil)
                return
            }
            
            // no http error
            completion("", data)
            
        })
        
        // start task
        dataTask.resume()
    }
    
    
    
    
    


}
