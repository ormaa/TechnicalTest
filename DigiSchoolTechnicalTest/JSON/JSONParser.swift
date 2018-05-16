//
//  JSONParser.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation




class MovieItemParser {

    // try to decode json as a JSONError class
    // if yes, the json returned is an error
    //
    func getJSONError(datas: Data?) -> String {
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(JSONError.self, from: datas!)
            return result.Error
        }
        catch {
            return ""
        }
    }
    
    
    // Decode json data to get MovieItem list
    //
    func jsonDecodeMovieList(datas: Data?) -> ([MovieItem], String) {

//        // convert data to string, print the result
//        var str: String?
//        if datas != nil {
//            str = String.init(data: datas!, encoding: .utf8)
//        }
//        print(str)
        
        let decoder = JSONDecoder()
        do {
            let item = try decoder.decode(MovieArray.self, from: datas!)
            let items = item.search
            return (items, "")
        }
        catch let err {
            let error = err.localizedDescription
            Tools.log("Json parsing error : " + error)
            return ([], error)
        }
    }
    
    
    // Decode json data into a MovieDetailItem class
    //
    func jsonDecodeMovieDetail(datas: Data?) -> (MovieDetailsItem?, String) {

        let decoder = JSONDecoder()
        do {
            let item = try decoder.decode(MovieDetailsItem.self, from: datas!)
            return (item, "")
        }
        catch let err {
            let error = err.localizedDescription
            Tools.log("Json parsing error : " + error)
            return (nil, error)
        }
    }
    
    
}
