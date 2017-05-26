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
        settingName.textAlignment = .center 
        return settingName
    }()
    
    func set(settingName: String) {
        settingNameLabel.text = settingName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        setup(nameLabel: settingNameLabel)
    }
    
    func setup(nameLabel: UILabel) {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
}
