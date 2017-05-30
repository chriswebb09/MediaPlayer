//
//  Playable.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/30/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol Playable {
    var playlist: Playlist { get set }
    var index: Int { get set }
    var playlistItem: PlaylistItem! { get set }
}
