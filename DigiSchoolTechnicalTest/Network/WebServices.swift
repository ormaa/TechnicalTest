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



//var url = "http://www.omdbapi.com/?i=tt3896198&apikey=9d307ea"

// need to add the search pattern at the end.
var searchURLString = "http://www.omdbapi.com/?apikey=9d307ea&s="


class WebServices {
    
    
    
    
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
            
            if error != nil {
                Tools.log("Web service error : " + urlString)
                Tools.log(error!.localizedDescription )
                completion("error : " + error!.localizedDescription, nil)
            }
            else {
                // no http error
//                var str: String?
//                if data != nil {
//                    str = String.init(data: data!, encoding: .utf8)
//                }
                // TODO : what should I do here if str could not be converted from data : I fire an error ? or I continue ???
                // Decision is needed.
                completion("", data)
            }
        })
        
        // start task
        dataTask.resume()
    }
    
    
    
    
    
    
    // call web service, allow to keep alive connection, even if ipad does nothing during long time
    func getMoviesList(searchPattern: String, completion:@escaping (_ error: String, _ data: Data?) -> Void) {
        
        let fullUrlString = searchURLString + searchPattern
        let urlString = fullUrlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        self.callWebService(urlString:  urlString!, completion: { (error, data) in
            completion(error, data)
        })
    }

}
