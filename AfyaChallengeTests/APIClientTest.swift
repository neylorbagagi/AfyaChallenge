//
//  APIClientTest.swift
//  AfyaChallengeTests
//
//  Created by Neylor Bagagi on 10/05/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import XCTest
@testable import AfyaChallenge

class APIClientTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetShows() {
        
        let requestExpectation = expectation(description: "request")
        
        APIClient().getShows(forPage: 0) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssert((data.count) > 0)
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testGetShowsByQuery() {
        
        let requestExpectation = expectation(description: "request")
        
        APIClient().getShows(byQuery:"girls") { (data, error) in
            XCTAssertNil(error)
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testGetEpisodes() {
        
        let requestExpectation = expectation(description: "request")
        
        APIClient().getEpisodes(forShow:1) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssert((data.count) > 0)
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
