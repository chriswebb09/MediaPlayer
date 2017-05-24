//
//  DataService.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class DataService {
    var tracks: [Track] = []
}


class NetworkService {

    var provider: MediaAPIClient
    
    init(provider: MediaAPIClient) {
        self.provider = provider
    }
    
}

