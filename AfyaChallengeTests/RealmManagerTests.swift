//
//  RealmManagerTests.swift
//  AfyaChallengeServicesTests
//
//  Created by Neylor Bagagi on 14/08/21.
//

import XCTest
@testable import AfyaChallenge
import RealmSwift

class RealmManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetShows() {
        
        let requestExpectation = expectation(description: "request")
        RealmManager.share.getShows(byPage: 0) { (data, error) in
            XCTAssertNil(error)
            XCTAssert(data.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetEpisodes(){
        
        let realm = try! Realm()
        guard let show = realm.object(ofType: Show.self, forPrimaryKey: 216) else{
            XCTFail("Show not found!")
            return
        }
        
        let requestExpectation = expectation(description: "request")
        let finalShow = RealmManager.share.getEpisodes(byShow:show){ (data, error) in
            XCTAssertNil(error)
            XCTAssert(data.count > 0, "must to have data")
            requestExpectation.fulfill()
        }
        XCTAssert(finalShow.episodes.count > 0, "must to have episodes")
        print(finalShow.episodes)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetImages(){
        
        let realm = try! Realm()
        guard let show = realm.object(ofType: Show.self, forPrimaryKey: 216) else{
            XCTFail("Show not found!")
            return
        }
        
        let requestExpectation = expectation(description: "request")
        let finalShow = RealmManager.share.getImages(byShow:show){ (data, error) in
            XCTAssertNil(error)
            XCTAssert(data != "", "must to have data")
            requestExpectation.fulfill()
        }
        
        print(finalShow.images["background"])
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCountShows() {
        
        guard let realm = try? Realm() else{
            fatalError("Cold not to load Realm")
        }

        let data = realm.objects(Show.self)
        print(data.count)
        
    }
    


}
