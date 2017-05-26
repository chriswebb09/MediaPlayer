//
//  SettingsView.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/26/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    var settingOneView: SettingsOptionView = {
        let settingOne = SettingsOptionView()
        settingOne.backgroundColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        settingOne.layer.borderColor = UIColor.white.cgColor
        settingOne.layer.borderWidth = 1
        return settingOne
    }()
    
    var settingTwoView: SettingsOptionView = {
        let settingTwo = SettingsOptionView()
        settingTwo.backgroundColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        settingTwo.layer.borderColor = UIColor.white.cgColor
        settingTwo.layer.borderWidth = 1
        return settingTwo
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup(settingOptionOne: settingOneView)
        setup(settingOptionTwo: settingTwoView)
    }
    
    func setup(settingOptionOne: SettingsOptionView) {
        addSubview(settingOptionOne)
        settingOptionOne.translatesAutoresizingMaskIntoConstraints = false
        settingOptionOne.topAnchor.constraint(equalTo: topAnchor).isActive = true
        settingOptionOne.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingOptionOne.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        settingOptionOne.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setup(settingOptionTwo: SettingsOptionView) {
        addSubview(settingOptionTwo)
        settingOptionTwo.translatesAutoresizingMaskIntoConstraints = false
        settingOptionTwo.topAnchor.constraint(equalTo: settingOneView.bottomAnchor).isActive = true
        settingOptionTwo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingOptionTwo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        settingOptionTwo.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
