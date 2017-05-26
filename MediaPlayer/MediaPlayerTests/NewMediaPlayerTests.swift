//
//  MediaPlayerTests.swift
//  MediaPlayerTests
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest
@testable import NewMediaPlayer

class MediaPlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetStoreSearchTerm() {
        let client = MediaAPIClient()
        let service = NetworkService(provider: client)
        let mediaStore = MediaDataStore(service: service)
        mediaStore.setSearch(string: "New")
        XCTAssert(mediaStore.searchTerm == "New", "Sets search term to new")
    }
    
    func testUrlConstructor() {
        let testTerm = "hello"
        guard let url = URLConstructor().build(searchTerm: testTerm) else { return }
        XCTAssert(url.absoluteString == "https://itunes.apple.com/search?media=music&entity=song&term=hello" , "URL is properly constructed")
    }
    
    func testPlayerView() {
        let model = PlayerViewModel(title: "Test", timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: "http://i.imgur.com/5gBiQe0.jpg")
        let playerView = PlayerView()
        let controller = PlayerViewController(playerView: playerView)
        controller.setModel(model: model)
        XCTAssert(controller.title == "Test", "Title is set to track")
    }
}
