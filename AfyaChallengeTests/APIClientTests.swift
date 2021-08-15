//
//  APIClientTests.swift
//  AfyaChallengeServicesTests
//
//  Created by Neylor Bagagi on 11/08/21.
//

import XCTest
@testable import AfyaChallenge

class APIClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetShows(){
        /// TODO: to test the quantity minimum 1 until 250
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShows(forPage: 0) { (data, error) in
            XCTAssertNil(error)
            XCTAssert(data.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetShow(){
        /// TODO: to test the quantity minimum 1 until 250
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShow(forId: 1) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetShowEpisodes() {
        
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShowEpisodes(forShow: 216) { (data, error) in
            XCTAssertNil(error)
            XCTAssert(data.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    func testGetShowImages() {
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShowImages(forShow: 216) { (data, error) in
            XCTAssertNil(error)
            XCTAssert(data.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetShowUpdates() {
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShowUpdates(since: APIClientShowUpdatePeriod.all) { (data, error) in
            XCTAssertNil(error)
            XCTAssert(data!.keys.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
