//
//  PlayerView.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct PlayerViewConstants {
    static let backButtonWidthMultiplier: CGFloat = 0.12
    static let backButtonHeightMultiplier: CGFloat = 0.11
    static let backButtonCenterYOffset: CGFloat = -0.08
    static let progressViewWidthMultiplier: CGFloat = 0.6
    static let progressViewHeightMultiplier: CGFloat = 0.005
    static let playTimeLabelHeightMutliplier: CGFloat = 0.25
    static let trackTitleViewHeightMultiplier: CGFloat = 0.06
    static let trackTitleLabelHeightMultiplier: CGFloat = 0.6
    static let trackTitleLabelCenterYOffset: CGFloat =  0.5
    static let artworkViewHeightMultiplier: CGFloat = 0.4
    static let albumWidthMultiplier: CGFloat = 0.4
    static let albumHeightMultiplier: CGFloat = 0.5
    static let preferenceHeightMultiplier: CGFloat = 0.05
    static let thumbsUpLeftOffset: CGFloat = 0.06
    static let artistInfoWidthMultiplier: CGFloat = 0.2
    static let artistInfoHeightMultiplier: CGFloat = 0.7
    static let artistInfoRightOffset: CGFloat = -0.05
    static let thumbsDownLeftOffset: CGFloat = 0.18
    static let controlsViewHeightMultiplier: CGFloat = 0.5
    static let thumbsHeightMultplier: CGFloat = 0.45
    static let thumbsWidthMultiplier: CGFloat = 0.04
}

protocol BaseViewModel { }

struct PlayerViewModel: BaseViewModel {
    let title: String
    let imageUrl: String
}

protocol BaseMediaView {
    var model: PlayerViewModel { get set }
}

class PlayerView: UIView {
    
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
