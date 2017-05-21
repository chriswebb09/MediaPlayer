//
//  PlayerViewController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

public class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    var playerView = PlayerView()
    var playlist: Playlist!
    
    var index: Int! 
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        let track = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = track?.track?.artistName
        playerView.frame = UIScreen.main.bounds
        var model = PlayerViewModel(title: "Test", imageUrl: "Test 2")
        playerView.configure(with: model)
        view.addSubview(playerView)
    }
}

extension PlayerViewController: PlayerViewDelegate {
    func backButtonTapped() {
        
    }

    func skipButtonTapped() {
        
    }

    func pauseButtonTapped() {
        
    }

    func playButtonTapped() {
        
    }
}
