//
//  TabBarController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
    
    var onItemFlowSelect: ((UINavigationController) -> ())?
    var onSettingsFlowSelect: ((UINavigationController) -> ())?
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        if let controller = customizableViewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        if selectedIndex == 0 {
            onItemFlowSelect?(controller)
        }
        else if selectedIndex == 1 {
            onSettingsFlowSelect?(controller)
        }
    }
}


//final class TabBarController: UITabBarController {
//    private func setupTabs() {
//        super.viewDidLoad()
//        setupControllers()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        setupTabBar(tabBar: tabBar, view: view)
//    }
//    
//    private func setupTabBar(tabBar: UITabBar, view: UIView) {
//        var tabFrame = tabBar.frame
//        let tabBarHeight = view.frame.height * 0.01
//        tabFrame.size.height = tabBarHeight
//        tabFrame.origin.y = view.frame.size.height - tabBarHeight
//        tabBar.frame = tabFrame
//        tabBar.isTranslucent = true
//    }
//    
//    private func setupControllers() {
//        let playerViewController = PlayerViewController()
//        let controllers = [playerViewController]
//    }
//    
//    private func setTabTitles(controllers: [UINavigationController]) {
//        viewControllers = controllers
//        tabBar.items?[0].title = "Tracks"
//        tabBar.items?[1].title = "Playlist"
//        selectedIndex = 0
//    }
//    
//    private func setupMediaTab(mediaCollectionViewController: MediaCollectionViewController) -> UINavigationController {
//        let tracksTab = UINavigationController(rootViewController: mediaCollectionViewController)
//        return tracksTab
//    }
//}
