//
//  Services.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

public struct Services {
    
    public let dataService: DataService
    
    public init() {
        self.dataService = DataService()
    }
}
