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
        
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let string = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        let cofee: Data? = string?.data(using: .utf8)
        let error = MovieItemParser().getJSONError(datas: cofee!)
        XCTAssertEqual(error, "")
        
        let (items, error2) = MovieItemParser().jsonDecode(datas: cofee!)
        XCTAssertEqual(error2, "")
        XCTAssertNotEqual(items.count , 0)

    }
    
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
    
}
