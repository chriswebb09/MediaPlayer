//
//  TabControllerDelegate.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TabControllerDelegate: class {
    func didSelectTrack(at index: Int, with playlist: Playlist)
}
