//
//  Service.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct Service: ServiceProtocol {
    
    let dataService: DataService
    
    init() {
        self.dataService = DataService()
    }
}
