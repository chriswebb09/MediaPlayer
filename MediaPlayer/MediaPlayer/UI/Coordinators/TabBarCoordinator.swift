//
//  TabBarCoordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TabbarCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var store = MediaDataStore(service: NetworkService(provider: MediaAPIClient()))
    let services: Services
    let mediaCollectionController: MediaCollectionViewController!
    var settingsController: SettingsViewController!
    let dataSource: BaseMediaControllerDataSource
    let window: UIWindow
    var tabbarController = TabBarController()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        self.dataSource = BaseMediaControllerDataSource(store: store)
        self.mediaCollectionController = MediaCollectionViewController(dataSource: dataSource)
        self.settingsController = SettingsViewController()
        self.window.rootViewController = tabbarController
        self.window.makeKeyAndVisible()
    }
    
    func start(viewController: UIViewController) {
        mediaCollectionController.delegate = self
        tabbarController.controllerDelegate = self
        tabbarController.setControllers(mediaCollectionController: mediaCollectionController, settingsController: settingsController)
    }
}

extension TabbarCoordinator: MediaControllerDelegate {
    
    func didSelectTrackAt(at index: Int, with playlist: Playlist) {
        print(index)
        let playerViewController = PlayerViewController()
        playerViewController.index = index
        playerViewController.playlist = playlist
    }
}

extension TabbarCoordinator: TabControllerDelegate {
    
    func didSelectTrack(at index: Int, with playlist: Playlist) {
        let playerView = PlayerView()
        let playerViewController = PlayerViewController(playerView: playerView)
        playerViewController.index = index
        playerViewController.playlist = playlist
        mediaCollectionController.navigationController?.pushViewController(playerViewController, animated: false)
    }
}
