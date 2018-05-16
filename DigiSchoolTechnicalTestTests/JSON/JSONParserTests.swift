//
//  JSONParserTests.swift
//  DigiSchoolTechnicalTestTests
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//




import Foundation
import XCTest
@testable import DigiSchoolTechnicalTest


class JSONParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMovieItemParser() {
        
        // movie list
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let string = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        let cofee: Data? = string?.data(using: .utf8)
        
        // test json data error
        let error = MovieItemParser().getJSONError(datas: cofee!)
        XCTAssertEqual(error, "")
        
        // test get movie list
        let (items, error2) = MovieItemParser().jsonDecodeMovieList(datas: cofee!)
        XCTAssertEqual(error2, "")
        XCTAssertNotEqual(items.count , 0)

        
        // movie details
        
        let path2 = Bundle.main.path(forResource: "json2", ofType: "txt")
        let string2 = try? String(contentsOfFile: path2!, encoding: String.Encoding.utf8)
        let cofee2: Data? = string2?.data(using: .utf8)
        
        // test get movie details
        let (item, error3) = MovieItemParser().jsonDecodeMovieDetail(datas: cofee2!)
        XCTAssertEqual(error3, "")
        XCTAssertNotEqual(item?.title , "")
    }
    
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
    
}
