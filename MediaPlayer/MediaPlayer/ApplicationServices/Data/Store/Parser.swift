//
//  Parser.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/29/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Parser {
    func parse(_ data: [String: Any]) -> DataCollection?
}

struct TrackParser: Parser {
    func parse(_ data: [String : Any]) -> DataCollection? {
        let playlist: Playlist? = Playlist()
        let tracksData = data["results"] as! [[String: Any]]
        tracksData.forEach {
            let track = Track(json: $0)
            let newItem: PlaylistItem? = PlaylistItem()
            newItem?.track = track
            playlist?.append(newPlaylistItem: newItem)
        }
        return playlist
    }
}
