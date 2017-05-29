//
//  PlaylistItem.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol DataItem { }
public class PlaylistItem: DataItem {
    var track: Track?
    var next: PlaylistItem?
    weak var previous: PlaylistItem?
}

extension PlaylistItem: Equatable {
    public static func ==(lhs: PlaylistItem, rhs: PlaylistItem) -> Bool {
        return lhs.track!.previewUrl! == rhs.track!.previewUrl!
    }
}
