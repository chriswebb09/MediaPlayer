//
//  Services.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol Services {
    var dataService: DataService { get set }
}

struct Service: ServiceProtocol {
    
    let dataService: DataService
    
    init() {
        self.dataService = DataService()
    }
}
