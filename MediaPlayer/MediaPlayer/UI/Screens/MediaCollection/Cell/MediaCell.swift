//
//  MediaCell.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct MediaCellConstants {
    static let smallFont = UIFont(name: "Avenir-Book", size: 10)
    static let albumHeightMultiplier: CGFloat =  0.86
    static let labelHeightMultiplier: CGFloat = 0.2
}


protocol MediaCellModeler {
    var trackName: String { get set }
    var albumImageUrl: URL { get set }
}

class MediaCellViewModel: MediaCellModeler {
    var trackName: String
    var albumImageUrl: URL
    
    init(trackName: String, albumImageURL: URL) {
        self.trackName = trackName
        self.albumImageUrl = albumImageURL
    }
}

class MediaCell: UICollectionViewCell, Reusable {
    
    private var viewModel: MediaCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            trackNameLabel.text = viewModel.trackName
            albumArtView.downloadImage(url: viewModel.albumImageUrl)
        }
    }
    
    private var trackNameLabel: UILabel = {
        var trackName = UILabel()
        trackName.backgroundColor = .white
        trackName.font = MediaCellConstants.smallFont
        trackName.textAlignment = .center
        trackName.numberOfLines = 0
        return trackName
    }()
    
    private var albumArtView: UIImageView = {
        var album = UIImageView()
        return album
    }()
    
    private func setShadow() {
        layer.setCellShadow(contentView: contentView)
        let path =  UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius)
        layer.shadowPath = path.cgPath
    }
    
    func configureCell(with model: MediaCellViewModel, withTime: Double) {
        alpha = 0
        viewModel  = model
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewConfigurations()
    }
    
    private func viewConfigurations() {
        setShadow()
        setupAlbumArt(albumArtView: albumArtView)
        setupTrackInfoLabel(trackNameLabel: trackNameLabel)
    }
    
    private func setupAlbumArt(albumArtView: UIImageView) {
        contentView.addSubview(albumArtView)
        albumArtView.translatesAutoresizingMaskIntoConstraints = false
        albumArtView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: MediaCellConstants.albumHeightMultiplier).isActive = true
        albumArtView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        albumArtView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    private func setupTrackInfoLabel(trackNameLabel: UILabel) {
        contentView.addSubview(trackNameLabel)
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: MediaCellConstants.labelHeightMultiplier).isActive = true
        trackNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        trackNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

