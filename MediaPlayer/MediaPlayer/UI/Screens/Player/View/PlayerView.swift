//
//  PlayerView.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class PlayerView: UIView {
    
    weak var delegate: PlayerViewDelegate?
    
    var model: PlayerViewModel! {
        didSet {
            titleLabel.text = model.title
            guard let imageUrl = URL(string: model.imageUrl) else { return }
            albumImageView.downloadImage(url: imageUrl)
        }
    }
    
    private var titleView: UIView = {
        let top = UIView()
        top.backgroundColor = .blue
        return top
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
   private var albumView: UIView = {
        let album = UIView()
        album.backgroundColor = .red
        return album
    }()
    
    private var albumImageView: UIImageView = {
        let albumImage = UIImageView()
        return albumImage
    }()
    
    private var activityView: UIView = {
        let activty = UIView()
        activty.backgroundColor = .cyan
        return activty
    }()
    
   private var preferencesView: UIView = {
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
    
    private func sharedTitleArtLayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    private func setup(titleView: UIView) {
        sharedTitleArtLayout(view: titleView)
        titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.trackTitleViewHeightMultiplier).isActive = true
        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    private func setup(titleLabel: UILabel) {
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor, multiplier: 0.5).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    private func setup(albumView: UIView) {
        sharedTitleArtLayout(view: albumView)
        albumView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: PlayerViewConstants.artworkViewHeightMultiplier).isActive = true
        albumView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        albumView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
    }
    
    private func setup(albumImageView: UIImageView) {
        albumView.addSubview(albumImageView)
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.centerXAnchor.constraint(equalTo: albumView.centerXAnchor).isActive = true
        albumImageView.centerYAnchor.constraint(equalTo: albumView.centerYAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumView.heightAnchor, multiplier: 0.25).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: albumView.widthAnchor, multiplier: 0.25).isActive = true
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
    
    private func setupViews() {
        layoutSubviews()
        setup(titleView: titleView)
        setup(titleLabel: titleLabel)
        setup(albumView: albumView)
        setup(albumImageView: albumImageView)
        setup(preferencesView: preferencesView)
        setup(controlsView: controlsView)
    }
}
