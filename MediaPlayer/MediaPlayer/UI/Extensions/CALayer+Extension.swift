//
//  CALayer+Extension.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct CALayerConstants {
    static let shadowWidthMultiplier: CGFloat = 0.00001
    static let shadowHeightMultiplier: CGFloat = 0.0002
}

extension CALayer {
    
    func setCellShadow(contentView: UIView) {
        let shadowOffsetWidth: CGFloat = contentView.bounds.height * CALayerConstants.shadowWidthMultiplier
        let shadowOffsetHeight: CGFloat = contentView.bounds.width * CALayerConstants.shadowHeightMultiplier
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        shadowRadius = 1.5
        shadowOpacity = 0.5
    }
}
