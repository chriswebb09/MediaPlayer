//
//  NetworkTests.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest

@testable import NewMediaPlayer
class NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParser() {
        let expect = expectation(description: "API Client returns proper number of items from search")
        let searchTerm = "new"
        let parser = TrackParser()
        MediaAPIClient.search(for: searchTerm) { response in
            switch response {
            case .success(let json):
                let tracks = parser.parse(json) as! Playlist
                XCTAssert(tracks.itemCount == 50)
                expect.fulfill()
            case .failed(let error):
                print(error.localizedDescription)
                assertionFailure()
            }
        }
        waitForExpectations(timeout: 6) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testNetworkRequest() {
        let expect = expectation(description: "API Client returns proper number of items from search")
        let searchTerm = "new"
        MediaAPIClient.search(for: searchTerm) { response in
            switch response {
            case .success(let json):
                XCTAssertNotNil(json)
                expect.fulfill()
            case .failed(let error):
                print(error.localizedDescription)
                assertionFailure()
            }
        }
        waitForExpectations(timeout: 6) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testSearch() {
        let dataSource = MediaDataStore()
        dataSource.setSearch(string: "new")
        let expect = expectation(description: "API Client returns proper number of items from search")
        dataSource.searchForTracks { playlist, error in
            XCTAssert(playlist?.itemCount == 50)
            expect.fulfill()
        }
        waitForExpectations(timeout: 6) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testNoInput() {
        let dataSource = MediaDataStore()
        dataSource.setSearch(string: "")
        let expect = expectation(description: "API Client returns proper number of items from search")
        dataSource.searchForTracks { playlist, error in
            XCTAssert(playlist?.itemCount == 0)
            expect.fulfill()
        }
        waitForExpectations(timeout: 6) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
