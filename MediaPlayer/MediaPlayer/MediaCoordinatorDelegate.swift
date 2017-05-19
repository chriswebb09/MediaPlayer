//
//  MediaCoordinatorDelegate.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol MediaCoordinatorDelegate: class {
    func mediCoordinator(didSelectTrackAt index: Int, withPlaylist: Playlist)
    func mediaCoordinatorDidRequestCancel(newMediaCoordinator: MediaCoordinator)
    func mediaCoordinator(newMediaCoordinator: MediaCoordinator, didAddTrack trackPayload: MediaCoordinatorPayload)
}
