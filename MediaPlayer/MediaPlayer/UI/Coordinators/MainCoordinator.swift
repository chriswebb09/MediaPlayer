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
    var window: UIWindow!
    
    @discardableResult
    init(coordinator: Coordinator, window: UIWindow) {
        self.appCoordinator = coordinator
        self.window = window
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        self.appCoordinator.start(viewController: splashViewController)
        appCoordinator.delegate = self
    }
}

extension MainCoordinator: CoordinatorDelegate {
    
    func transitionCoordinator() {
        let tabbarController = TabBarController()
        let tabCoordinator = TabbarCoordinator(window: window, tabbarController: tabbarController)
        appCoordinator = tabCoordinator
        tabCoordinator.start(viewController: tabbarController)
    }
}
