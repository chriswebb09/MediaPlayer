//
//  TabBarController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    private func setupTabs() {
        super.viewDidLoad()
        setupControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTabBar(tabBar: tabBar, view: view)
    }
    
    private func setupTabBar(tabBar: UITabBar, view: UIView) {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.height * 0.01
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.isTranslucent = true
    }
    
    private func setupControllers() {
        //let mediaCollectionController = MediaCollectionViewController()
        let playerViewController = PlayerViewController()
        let controllers = [playerViewController]
//        UITabBar.appearance().tintColor = UIColor.orange
//        let dataSource = ListControllerDataSource(store: store!)
//        let tracksController = TracksViewController(dataSource: dataSource)
//        let playlistController = PlaylistsViewController()
//        let searchTab = setupSearchTab(tracksViewController: tracksController)
//        let playlistTab = setupPlaylistTab(playlistViewController: playlistController)
//        let controllers = [searchTab, playlistTab]
//        setTabTitles(controllers: controllers)
    }
    
    private func setTabTitles(controllers: [UINavigationController]) {
        viewControllers = controllers
        tabBar.items?[0].title = "Tracks"
        tabBar.items?[1].title = "Playlist"
        selectedIndex = 0
    }
    
    private func setupMediaTab(mediaCollectionViewController: MediaCollectionViewController) -> UINavigationController {
       // let dataSource = ListControllerDataSource(store: store!)
        //dataSource.store = self.store!
      //  tracksViewController.dataSource = dataSource
     //   tracksViewController.tabBarItem = UITabBarItem(title: nil, image: normalImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysTemplate))
        
        let tracksTab = UINavigationController(rootViewController: mediaCollectionViewController)
        return tracksTab
    }
}
