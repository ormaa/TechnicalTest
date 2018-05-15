//
//  DetailsViewModelTests.swift
//  DigiSchoolTechnicalTestTests
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//


import Foundation
import XCTest
@testable import DigiSchoolTechnicalTest


class DetailsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    

    func testDownloadImage() {
        
        //I need that to test async code
        let myExpectation = expectation(description: "test callback closure")
        
        // be careful here. I need to check often if the pattern search do not return more entries.
        // TODO : find another way to test this. somthing which would return always the correct number of entries
        let vm = MainViewModel()
        // https://images-na.ssl-images-amazon.com/images/M/MV5BMTk0NjUwODgwOF5BMl5BanBnXkFtZTcwNjcxNTg2Mw@@._V1_SX300.jpg
        // http://greenwoodhypno.co.uk/wp-content/uploads/2014/09/test-image.png
        
        
        
        // wait for the closure to be called
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    

    
}
