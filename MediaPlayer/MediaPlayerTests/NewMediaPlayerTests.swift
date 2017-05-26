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
    
    func testSplashCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController =  SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        XCTAssert(appCoordinator.navigationController.viewControllers[0] == splashViewController, "Navigation viewcontrollers is StartViewController")
    }
    
    func testStartCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        XCTAssert(appCoordinator.navigationController.viewControllers[0].view.tag == 0, "View is of type startView / tag == 0")
    }
    
    func testGoToLogin() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.loginTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 1, "View is of type LoginView / tag == 1")
    }
    
    func testGoToCreateAccount() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.createAccountTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 3, "View is of type startView / tag == 0")
    }
    
    
    func testPlayerView() {
        let model = PlayerViewModel(title: "Test", imageUrl: "http://i.imgur.com/5gBiQe0.jpg")
        let playerView = PlayerView()
        let controller = PlayerViewController(playerView: playerView)
        controller.setModel(model: model)
        XCTAssert(controller.title == "Test", "Title is set to track")
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
        waitForExpectations(timeout: 4) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}
