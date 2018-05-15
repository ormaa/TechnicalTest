//
//  MainViewModelTests.swift
//  DigiSchoolTechnicalTestTests
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import XCTest
@testable import DigiSchoolTechnicalTest


class MainViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    }
    
    func testGetMovieList() {
        
        //I need that to test async code
        let myExpectation = expectation(description: "test callback closure")

        // be careful here. I need to check often if the pattern search do not return more entries.
        // TODO : find another way to test this. somthing which would return always the correct number of entries
        let vm = MainViewModel()
        vm.getMoviesList(filterName: "harry", completion: { (error) in
            
            XCTAssertEqual(error, "")
            XCTAssertEqual(vm.moviesItems.count, 10)

            // Validate that the colsure was called
            myExpectation.fulfill()
        })
        
        // wait for the closure to be called
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
    
}
