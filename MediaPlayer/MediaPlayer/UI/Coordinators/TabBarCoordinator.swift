//
//  TabBarCoordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TabbarCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    
    // MARK: - Properties
    
    var mediaCollectionController: MediaCollectionViewController!
    var settingsController: SettingsViewController!
    var dataSource: BaseMediaControllerDataSource!
    var window: UIWindow!
    var tabbarController: TabBarController!

    // MARK: - Init
    
    init(window: UIWindow, tabbarController: TabBarController = TabBarController()) {
        self.setStore(from: MediaAPIClient())
        var settingsView = SettingsView()
        self.settingsController = SettingsViewController(settingsView: settingsView)
        self.tabbarController = tabbarController
        setWindow(window: window)
    }
    
    func setWindow(window: UIWindow) {
        self.window = window
        self.window.rootViewController = tabbarController
        self.window.makeKeyAndVisible()
    }
    
    func setupTabController(tabController: TabBarController) {
        tabbarController.controllerDelegate = self
        tabbarController.setControllers(mediaCollectionController: mediaCollectionController, settingsController: settingsController)
    }
    
    func start(viewController: UIViewController) {
        mediaCollectionController.delegate = self
        setupTabController(tabController: tabbarController)
    }
    
    func controllerAtIndex(index: Int) {
        tabbarController.selectedIndex = index
        let navController = tabbarController.viewControllers?[0] as! UINavigationController
        navController.popViewController(animated: false)
    }
    
    func setStore(from client: MediaAPIClient) {
        let networkService = NetworkService(provider: client)
        let store = MediaDataStore(service: networkService)
        self.dataSource = BaseMediaControllerDataSource(store: store)
        let collectionView = MediaCollectionViewController(dataSource: dataSource)
        self.mediaCollectionController = collectionView
    }
}

extension TabbarCoordinator: MediaControllerDelegate {
    
    func didSelectTrackAt(at index: Int, with playlist: Playlist) {
        print(index)
    }
}

extension TabbarCoordinator: TabControllerDelegate {
    
    func didSelectTrack(at index: Int, with playlist: Playlist) {
        let playerView = PlayerView()
        let playerViewController = PlayerViewController(playerView: playerView)
        playerViewController.index = index
        playerViewController.playlist = playlist
        tabbarController.tabBar.alpha = 0
        mediaCollectionController.navigationController?.pushViewController(playerViewController, animated: false)
    }
}
