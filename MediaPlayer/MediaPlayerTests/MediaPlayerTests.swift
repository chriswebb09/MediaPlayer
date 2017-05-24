//
//  MediaPlayerTests.swift
//  MediaPlayerTests
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest
@testable import MediaPlayer

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
    
    func testSplashCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow(), services: Services())
        let splashViewController =  SplashViewController()
        appCoordinator.start(viewController:splashViewController)
        XCTAssert(appCoordinator.navigationController.viewControllers[0] == splashViewController, "Navigation viewcontrollers is StartViewController")
    }
    
    func testStartCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow(), services: Services())
        let splashViewController = SplashViewController()
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        XCTAssert(appCoordinator.navigationController.viewControllers[0].view.tag == 0, "View is of type startView / tag == 0")
    }
    
    
    func testPlayerView() {
        let model = PlayerViewModel(title: "Test", imageUrl: "http://i.imgur.com/5gBiQe0.jpg")
        let playerView = PlayerView()
        var controller = PlayerViewController(playerView: playerView)
        controller.setModel(model: model)
        XCTAssert(controller.title == "Test", "Title is set to track")
    }
    
}
