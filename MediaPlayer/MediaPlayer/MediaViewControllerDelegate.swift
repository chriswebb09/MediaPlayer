//
//  MediaViewControllerDelegate.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol MediaCollectionHandler: class {
    func didSearchForTrack(with term: String)
    //func didTapClose(mediaViewController: MediaCollectionViewController)
}

public protocol MediaViewControllerDelegate:  class {
    func didTapClose(mediaViewController: MediaCollectionViewController)
    func didSelectPlaylistItem(at index: Int, for list: Playlist)
    //func drinkTypeViewControllerDidTapClose(_ drinkTypeViewController: DrinkTypeViewController)
//    func playerViewControllerDidTapClose(_ mediaCoordinator: MediaCoordinator)
}
