//
//  MediaCoordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MediaCoordinator: RootViewCoordinator {
    
    let services: Services
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: MediaCoordinatorDelegate?
    
    var orderPayload: MediaCoordinatorPayload?
    
    var dataSource: BaseMediaControllerDataSource
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Init
    
    init(services: Services, dataSource: BaseMediaControllerDataSource) {
        self.services = services
        self.dataSource = dataSource
    }
    
    // MARK: - Functions
    
    func start() {
        let mediaViewController = MediaCollectionViewController(dataSource: dataSource)
        mediaViewController.delegate = self as MediaViewControllerDelegate
        self.navigationController.viewControllers = [mediaViewController]
    }
    
    func showPlayerViewController() {
        let playerViewController = PlayerViewController()
        playerViewController.delegate = self
        self.navigationController.pushViewController(playerViewController, animated: false)
    }
    
}

// MARK: - MediaCoordinatorDelegate

extension MediaCoordinator: MediaCoordinatorDelegate {
    
    func mediCoordinator(didSelectTrackAt index: Int, withPlaylist: Playlist) {
        delegate?.mediCoordinator(didSelectTrackAt: index, withPlaylist: withPlaylist)
    }

    func mediaCoordinator(newMediaCoordinator: MediaCoordinator, didAddTrack trackPayload: MediaCoordinatorPayload) {
        
    }

    func mediaCoordinatorDidRequestCancel(newMediaCoordinator: MediaCoordinator) {
        
    }

}

// MARK: - MediaViewControllerDelegate

extension MediaCoordinator: MediaViewControllerDelegate {
    func didSelectPlaylistItem(at index: Int, for list: Playlist) {
        showPlayerViewController()
    }
    
    func didTapClose(mediaViewController: MediaCollectionViewController) {
        self.delegate?.mediaCoordinatorDidRequestCancel(newMediaCoordinator: self)
    }

}

// MARK: - PlayerViewControllerDelegate

extension MediaCoordinator: PlayerViewControllerDelegate {
    

}
