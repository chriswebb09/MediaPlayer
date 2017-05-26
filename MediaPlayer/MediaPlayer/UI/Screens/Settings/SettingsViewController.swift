//
//  SettingsViewController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        settingsView.backgroundColor = .cyan
        settingsView.layoutSubviews()
        view.addView(view: settingsView, type: .full)
        view = settingsView
        title = "Settings"
    }
}
