//
//  MainCoordinator.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class MainCoordinator {
    
    var appCoordinator: Coordinator
    
    @discardableResult
    init(coordinator: Coordinator) {
        self.appCoordinator = coordinator
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        self.appCoordinator.start(viewController: splashViewController)
    }
}
