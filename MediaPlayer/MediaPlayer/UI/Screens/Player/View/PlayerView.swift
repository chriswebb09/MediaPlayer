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
    
    private var model: PlayerViewModel! {
        didSet {
            titleLabel.text = model.title
            guard let imageUrl = URL(string: model.imageUrl) else { return }
            albumImageView.downloadImage(url: imageUrl)
            model.timer = Timer.init()
        }
    }
    
    private var timer: Timer?
    
    private var titleView: UIView = {
        let top = UIView()
        top.backgroundColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        return top
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    private var albumView: UIView = {
        let album = UIView()
        album.backgroundColor = .lightGray
        return album
    }()
    
    private var albumImageView: UIImageView = {
        let albumImage = UIImageView()
        return albumImage
    }()
    
    private var activityView: UIView = {
        let activty = UIView()
        activty.backgroundColor = .darkGray
        return activty
    }()
    
    private var preferencesView: UIView = {
        let preferences = UIView()
        preferences.backgroundColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        return preferences
    }()
    
    var controlsView: UIView = {
        let controls = UIView()
        controls.backgroundColor = UIColor(red:0.10, green:0.09, blue:0.12, alpha:1.0)
        return controls
    }()
    
    private var playButton: UIButton = {
        var playButton = UIButton()
        playButton.setImage(#imageLiteral(resourceName: "bordered-white-play"), for: .normal)
        return playButton
    }()
    
    private var pauseButton: UIButton = {
        var pauseButton = UIButton()
        pauseButton.setImage(#imageLiteral(resourceName: "white-bordered-pause"), for: .normal)
        return pauseButton
    }()
    
    private var skipButton: UIButton = {
        var skipButton = UIButton()
        skipButton.setImage(#imageLiteral(resourceName: "skip-white-hollow-icon"), for: .normal)
        return skipButton
    }()
    
    private var backButton: UIButton = {
        var backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back-white-hollow"), for: .normal)
        return backButton
    }()
    
    private var playtimeSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        slider.tintColor = .white
        slider.isUserInteractionEnabled = true
        return slider
    }()
    
    private var moreButton: UIButton = {
        var moreButton = UIButton()
        moreButton.setImage(#imageLiteral(resourceName: "morebutton"), for: .normal)
        return moreButton
    }()
    
    func configure(with model: PlayerViewModel) {
        self.model = model
        setupViews()
        pauseButton.alpha = 0
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
        albumImageView.heightAnchor.constraint(equalTo: albumView.heightAnchor, multiplier: 0.7).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: albumView.widthAnchor, multiplier: 0.65).isActive = true
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
    
    private func setup(trackButton: UIButton) {
        controlsView.addSubview(trackButton)
        trackButton.translatesAutoresizingMaskIntoConstraints = false
        trackButton.heightAnchor.constraint(equalTo: controlsView.heightAnchor, multiplier: 0.27).isActive = true
        trackButton.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor, constant: UIScreen.main.bounds.height * -0.03).isActive = true
        trackButton.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
    }
    
    private func setup(playButton: UIButton, pauseButton: UIButton) {
        setup(trackButton: playButton)
        playButton.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.25).isActive = true
        setup(trackButton: pauseButton)
        pauseButton.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setup(slider: UISlider) {
        controlsView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: controlsView.topAnchor, constant: UIScreen.main.bounds.height * 0.08).isActive = true
        slider.heightAnchor.constraint(equalTo: controlsView.heightAnchor, multiplier: 0.01).isActive = true
        slider.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func skipButtonsSharedLayout(controlsView: UIView, button: UIButton) {
        controlsView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: PlayerViewConstants.backButtonWidthMultiplier).isActive = true
        button.heightAnchor.constraint(equalTo: controlsView.heightAnchor, multiplier: PlayerViewConstants.backButtonHeightMultiplier).isActive = true
    }
    
    private func setup(skipButton: UIButton, backButton: UIButton) {
        skipButtonsSharedLayout(controlsView: controlsView, button: skipButton)
        skipButton.rightAnchor.constraint(equalTo: controlsView.rightAnchor, constant: UIScreen.main.bounds.width * -0.16).isActive = true
        skipButton.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor, constant: UIScreen.main.bounds.height * -0.03).isActive = true
        skipButtonsSharedLayout(controlsView: controlsView, button: backButton)
        backButton.leftAnchor.constraint(equalTo: controlsView.leftAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
        backButton.centerYAnchor.constraint(equalTo: controlsView.centerYAnchor, constant: UIScreen.main.bounds.height * -0.03).isActive = true
    }
    
    private func setupViews() {
        layoutSubviews()
        setup(titleView: titleView)
        setup(titleLabel: titleLabel)
        setup(albumView: albumView)
        setup(albumImageView: albumImageView)
        setup(preferencesView: preferencesView)
        setup(controlsView: controlsView)
        setup(playButton: playButton, pauseButton: pauseButton)
        setup(slider: playtimeSlider)
        setup(skipButton: skipButton, backButton: backButton)
        addSelectors()
    }
    
    @objc private func sliderValueChanged() {
        print(playtimeSlider.value)
    }
    
    private func addSelectors() {
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        playtimeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func playButtonTapped() {
        guard var model = model else { return }
        let timerDic: NSMutableDictionary = ["count": model.time]
        setTimer(timerDict: timerDic)
        switchButtonAlpha(for: pauseButton, withButton: playButton)
        delegate?.playButtonTapped()
    }
    
    private func switchButtonAlpha(for button: UIButton, withButton: UIButton) {
        button.alpha = 1
        withButton.alpha = 0
    }
    
    @objc private func pauseButtonTapped() {
        guard let countDict = timer?.userInfo as? NSMutableDictionary else { return }
        pauseTime(countdict: countDict)
        switchButtonAlpha(for: playButton, withButton: pauseButton)
        delegate?.pauseButtonTapped()
    }
    
    @objc private func skipButtonTapped() {
        playButton.alpha = 1
        playtimeSlider.value = 0
        timer?.invalidate()
        delegate?.skipButtonTapped()
    }
    
   @objc private func backButtonTapped() {
        playButton.alpha = 1
        playtimeSlider.value = 0
        timer?.invalidate()
        delegate?.backButtonTapped()
    }
    
    private func setTimer(timerDict: NSMutableDictionary) {
        guard var model = model else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: timerDict, repeats: true)
    }
    
    private func pauseTime(countdict: NSMutableDictionary) {
        guard var model = model else { return }
        if let count = countdict["count"] as? Int {
            countdict["count"] = count
            model.time = count
            timer?.invalidate()
        }
    }
    
    @objc private func updateTime() {
        guard let countDict = timer?.userInfo as? NSMutableDictionary else { return }
        guard let count = countDict["count"] as? Int else { return }
        model.time = count + 1
        model.progressIncrementer += 0.001
        playtimeSlider.value += model.progressIncrementer
        model.progress = playtimeSlider.value
    }
}
