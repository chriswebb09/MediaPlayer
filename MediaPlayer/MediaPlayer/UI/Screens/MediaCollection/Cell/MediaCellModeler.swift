//
//  MediaCellModeler.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol MediaCellModeler {
    var trackName: String { get set }
    var albumImageUrl: URL { get set }
}
