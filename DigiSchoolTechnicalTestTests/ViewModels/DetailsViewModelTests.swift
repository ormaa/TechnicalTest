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
        
        // https://images-na.ssl-images-amazon.com/images/M/MV5BMTk0NjUwODgwOF5BMl5BanBnXkFtZTcwNjcxNTg2Mw@@._V1_SX300.jpg
        let imageURLString = "http://greenwoodhypno.co.uk/wp-content/uploads/2014/09/test-image.png"
        WebServices().downloadImage(url: imageURLString, completion: { (error, data) in
            
            XCTAssertEqual(error, "")
            XCTAssertNotEqual(data, nil)
            
            // get resource image
            let testImage = UIImage(named: "test-image")
            let testData = UIImagePNGRepresentation(testImage!)!
            // loaded data, converted back with same class UIImagePNGRepresentation
            let loadedImage = UIImage(data: data!)
            let loadedData = UIImagePNGRepresentation(loadedImage!)!
            XCTAssertEqual(testData, loadedData)
            
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
    
    

    
}
