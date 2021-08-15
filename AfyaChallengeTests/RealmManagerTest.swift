//
//  RealmManagerTest.swift
//  AfyaChallengeTests
//
//  Created by Neylor Bagagi on 09/08/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import XCTest
@testable import AfyaChallenge

class RealmManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetShows(){
        
        let requestExpectation = expectation(description: "request")
        
        RealmManager.shared.getShows(forPage: 1) { (data, error) in
            XCTAssertNil(error)
            XCTAssert((data.count > 0), "must be more than 0")
            XCTAssert((data.count <= 250), "must be never more than 250")
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
