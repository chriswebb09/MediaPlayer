//
//  PlayerViewControllerTests.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/29/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest

@testable import NewMediaPlayer
class PlayerViewControllerTests: XCTestCase {
    
    var trackOne: Track!
    var trackTwo: Track!
    var playlist: Playlist!
    var playerView: PlayerView!
    var model: PlayerViewModel!
    var playerViewController: PlayerViewController!
    
    override func setUp() {
        self.playlist = Playlist()
        model = PlayerViewModel(title: "Test",
                                timer: nil,
                                progressIncrementer: 0,
                                time: 0,
                                progress: 0,
                                imageUrl: "http://i.imgur.com/5gBiQe0.jpg")
        self.trackOne = Track(trackName: "Test track one",
                              artistName: "Test Artist One",
                              artistId: 01,
                              previewUrl: "http://i.imgur.com/5gBiQe0.jpg",
                              artworkUrl: "http://i.imgur.com/5gBiQe0.jpg",
                              collectionName: "test collection one")
        self.trackTwo = Track(trackName: "Test track two",
                              artistName: "Test Artist two",
                              artistId: 02,
                              previewUrl: "http://i.imgur.com/5gBiQe0.jpg",
                              artworkUrl: "http://i.imgur.com/5gBiQe0.jpg",
                              collectionName: "test collection two")
        let itemOne = PlaylistItem()
        itemOne.track = trackOne
        let itemTwo = PlaylistItem()
        itemTwo.track = trackTwo
        playlist.append(newPlaylistItem: itemOne)
        playlist.append(newPlaylistItem: itemTwo)
        self.playerView = PlayerView()
        self.playerViewController = PlayerViewController(index: 0, playlist: playlist)
        super.setUp()
    }
    
    override func tearDown() {
        trackOne = nil
        trackTwo = nil
        playerView = nil
        playerViewController = nil
        self.playlist = nil
        super.tearDown()
    }
    
    func testPlayerViewControllerSetup() {
        playerViewController.setModel(model: model)
        playerViewController.viewDidLoad()
        XCTAssert(playerViewController.title == "Test Artist One", "Title is set to track")
    }
    
    func testSkipButton() {
        playerViewController.viewDidLoad()
        XCTAssert(playerViewController.title == "Test Artist One", "Title is set to track")
        XCTAssert(playerViewController.index == 0, "Index is zero")
        playerViewController.skipButtonTapped()
        XCTAssert(playerViewController.title == "Test Artist two", "Title is set to track")
        XCTAssert(playerViewController.index == 1, "Index is one")
    }
    
    func testBackButton() {
        playerViewController.viewDidLoad()
        XCTAssert(playerViewController.title == "Test Artist One", "Title is set to track")
        XCTAssert(playerViewController.index == 0, "Index is zero")
        playerViewController.backButtonTapped()
        XCTAssert(playerViewController.title == "Test Artist One", "Title is set to track")
        XCTAssert(playerViewController.index == 0, "Index is zero")
        playerViewController.skipButtonTapped()
        XCTAssert(playerViewController.title == "Test Artist two", "Title is set to track")
        XCTAssert(playerViewController.index == 1, "Index is one")
        playerViewController.backButtonTapped()
        XCTAssert(playerViewController.title == "Test Artist One", "Title is set to track")
        XCTAssert(playerViewController.index == 0, "Index is zero")
    }
}
