//
//  PlayerViewModel.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct PlayerViewModel: BaseViewModel {
    let title: String
    var timer: Timer?
    var progressIncrementer: Float = 0
    var time: Int = 0
    var progress: Float = 0
    let imageUrl: String
    
}
