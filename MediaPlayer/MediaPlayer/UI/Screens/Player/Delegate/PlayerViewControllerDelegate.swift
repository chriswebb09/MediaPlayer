//
//  PlayerViewControllerDelegate.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol PlayerViewControllerDelegate: class {
    func playButtonTapped()
    func pauseButtonTapped()
    func skipButtonTapped()
}
