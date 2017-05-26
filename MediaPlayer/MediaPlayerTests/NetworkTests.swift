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
        waitForExpectations(timeout: 4) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testSearch() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
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
    
    func testPlay() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        let controller = PlayerViewController(playerView: playerView)
        dataSource.searchForTracks { playlist, error in
            controller.playlist = playlist
            controller.index = 1
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist?.playlistItem(at: 1), "PlaylistItem is first track" )
        }
        controller.playButtonTapped()
        XCTAssert(controller.playerState == .playing, "Player state is playing")
    }
    
    func testPause() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        let controller = PlayerViewController(playerView: playerView)
        dataSource.searchForTracks { playlist, error in
            controller.playlist = playlist
            controller.index = 1
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist?.playlistItem(at: 1), "PlaylistItem is first track" )
        }
        controller.playButtonTapped()
        controller.pauseButtonTapped()
        XCTAssert(controller.playerState == .paused, "Player state is paused")
    }
    
    func testSkip() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        let controller = PlayerViewController(playerView: playerView)
        var playerlist: Playlist!
        dataSource.searchForTracks { playlist, error in
            controller.playlist = playlist
            playerlist = playlist
            controller.index = 1
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist?.playlistItem(at: 1), "PlaylistItem is first track" )
        }
        controller.skipButtonTapped()
        XCTAssert(controller.playlistItem == playerlist?.playlistItem(at: 2), "PlaylistItem is second track" )
        XCTAssert(controller.playerState == .queued, "Track is queued")
    }

}
