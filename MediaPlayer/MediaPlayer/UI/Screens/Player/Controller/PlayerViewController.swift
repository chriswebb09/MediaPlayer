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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        playerView.frame = UIScreen.main.bounds
        var model = PlayerViewModel(title: "Test", imageUrl: "Test 2")
        playerView.configure(with: model)
        view.addSubview(playerView)
    }
}
