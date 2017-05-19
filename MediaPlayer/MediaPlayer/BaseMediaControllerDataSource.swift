//
//  BaseMediaControllerDataSource.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class BaseMediaControllerDataSource {
    var image = #imageLiteral(resourceName: "search-button").withRenderingMode(.alwaysOriginal)
    
    var store: MediaDataStore
    var playlist: Playlist?
    var tracks: [Track]?
    
    var count: Int {
        guard let playlist = playlist else { return 0 }
        return playlist.itemCount
    }
    
    init(store: MediaDataStore) {
        self.store = store
    }
    
}
