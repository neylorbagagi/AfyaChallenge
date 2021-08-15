//
//  EpisodeTests.swift
//  AfyaChallengeServicesTests
//
//  Created by Neylor Bagagi on 14/08/21.
//

import XCTest
@testable import AfyaChallenge

class EpisodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeFromAPIResponse() throws {
        let requestExpectation = expectation(description: "request")
        
        APIClient.share.getShowEpisodes(forShow: 216) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNoThrow(try! Episode(data.first!), "Throw error during constructor")
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
