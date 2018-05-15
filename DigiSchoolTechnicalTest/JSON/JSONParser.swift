//
//  JSONParser.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation


class JSONError: Codable {
    var Response = ""
    var Error = ""
}


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
    
    var title: String = ""
    var year: String? = ""
    var poster: String? = ""
    var movieType: String? = ""
    
    // define how to map value between class and json text
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case movieType = "MovieType"
    }
    
}

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
    
    
    // Decode json data into a MovieItem class
    func jsonDecode(datas: Data?) -> ([MovieItem], String) {

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
    
}
