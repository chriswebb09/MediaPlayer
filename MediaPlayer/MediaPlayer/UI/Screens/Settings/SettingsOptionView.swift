//
//  SettingsOptionView.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsOptionView: UIView {
    
    private var settingNameLabel: UILabel = {
        let settingName = UILabel()
        return settingName
    }()
    
    func set(settingName: String) {
        settingNameLabel.text = settingName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
    }
}
