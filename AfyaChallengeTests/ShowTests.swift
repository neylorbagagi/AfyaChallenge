//
//  ShowTests.swift
//  AfyaChallengeServicesTests
//
//  Created by Neylor Bagagi on 13/08/21.
//

import XCTest
@testable import AfyaChallenge

class ShowTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowFromAPIResponse() throws {
        let requestExpectation = expectation(description: "request")
        APIClient.share.getShow(forId: 216) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNoThrow(try! Show(data!), "Throw error during constructor")
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testShowsFromAPIResponse() throws {
        let requestExpectation = expectation(description: "request")
        
        var responseData:[ShowRequestResponse] = []
        APIClient.share.getShows(forPage: 0) {(data, error) in
            XCTAssertNil(error)
            responseData = data
            requestExpectation.fulfill()
        }
        XCTAssertNoThrow(try Show.showsFromAPIResponse(responseData), "Throw error during constructor")
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
