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
}
