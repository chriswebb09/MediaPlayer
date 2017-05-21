//
//  PlayerView.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    weak var delegate: PlayerViewDelegate?
    var model: PlayerViewModel!
    
    var titleView: UIView = {
        let top = UIView()
        top.backgroundColor = .blue
        return top
    }()
    
    var albumView: UIView = {
        let album = UIView()
        album.backgroundColor = .red
        return album
    }()
    
    var activityView: UIView = {
        let activty = UIView()
        activty.backgroundColor = .cyan
        return activty
    }()
    
    var preferencesView: UIView = {
        let preferences = UIView()
        preferences.backgroundColor = .green
        return preferences
    }()
    
    var controlsView: UIView = {
        let controls = UIView()
        controls.backgroundColor = .darkGray
        return controls
    }()
    
    func configure(with model: PlayerViewModel) {
        self.model = model
        setupViews()
    }
    
    func sharedTitleArtLayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    private func setup(titleView: UIView) {
        sharedTitleArtLayout(view: titleView)
        titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.trackTitleViewHeightMultiplier).isActive = true
        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    private func setup(albumView: UIView) {
        sharedTitleArtLayout(view: albumView)
        albumView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.artworkViewHeightMultiplier).isActive = true
        albumView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        albumView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
    }
    
    private func setup(preferencesView: UIView) {
        sharedTitleArtLayout(view: preferencesView)
        preferencesView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.preferenceHeightMultiplier).isActive = true
        preferencesView.topAnchor.constraint(equalTo: albumView.bottomAnchor).isActive = true
    }
    
    private func setup(controlsView: UIView) {
        sharedTitleArtLayout(view: controlsView)
        controlsView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.controlsViewHeightMultiplier).isActive = true
        controlsView.topAnchor.constraint(equalTo: preferencesView.bottomAnchor).isActive = true
    }
    
    func setupViews() {
        layoutSubviews()
        setup(titleView: titleView)
        setup(albumView: albumView)
        setup(preferencesView: preferencesView)
        setup(controlsView: controlsView)
    }
}
