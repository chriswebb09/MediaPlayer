//
//  MediaCollectionCoordinator.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 6/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

dynamic class MediaCollectionCoordinator: NavigationCoordinator {
    
    weak var delegate: CoordinatorDelegate?
    weak var tabDelegate: TabDelegate?
    
    var mediaController: MediaCollectionViewController!
    
    var childViewControllers: [UIViewController] = []
    
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(navigationController: UINavigationController, mediaCollectionController: MediaCollectionViewController) {
        self.init(navigationController: navigationController)
        mediaController = mediaCollectionController
        mediaController.delegate = self
        navigationController.viewControllers = [mediaController]
        childViewControllers = navigationController.viewControllers
    }
    
    func start() {
        showMediaController(mediaCollectionController: mediaController)
    }
    
    fileprivate func showMediaController(mediaCollectionController: MediaCollectionViewController) {
        childViewControllers = [mediaController]
        navigationController.viewControllers = [mediaController]
    }
}


extension MediaCollectionCoordinator: MediaCollectionDelegate {
    
    func didSelectTrackAt(at index: Int, with playlist: Playlist) {
        let playerViewController = PlayerViewController(index: index, playlist: playlist)
        navigationController.pushViewController(playerViewController, animated: false)
    }
}



