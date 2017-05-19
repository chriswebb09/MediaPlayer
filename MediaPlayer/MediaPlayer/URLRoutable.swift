//
//  URLRoutable.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum Response {
    case success(JSON), failed(Error)
}

enum URLRouter {
    
    case base, path
    
    var url: String {
        switch self {
        case .base:
            return "https://itunes.apple.com"
        case .path:
            return "/search?media=music&entity=song&term="
        }
    }
}
