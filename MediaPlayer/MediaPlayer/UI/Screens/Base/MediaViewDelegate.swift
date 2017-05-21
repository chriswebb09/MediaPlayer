//
//  MediaViewDelegate.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol MediaControllerDelegate: class {
    
    func didSelectTrackAt(at index: Int, with playlist: Playlist)
    
}
