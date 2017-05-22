//
//  MediaCellViewModel.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class MediaCellViewModel: MediaCellModeler {
    
    var trackName: String
    var albumImageUrl: URL
    
    init(trackName: String, albumImageURL: URL) {
        self.trackName = trackName
        self.albumImageUrl = albumImageURL
    }
}
