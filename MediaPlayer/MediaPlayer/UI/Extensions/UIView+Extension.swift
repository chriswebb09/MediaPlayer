//
//  UIView+Extension.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIView {
    
    func addView(view: UIView, type: ViewType) {
        switch type {
        case .full:
            view.frame = UIScreen.main.bounds
            addSubview(view)
            view.layoutSubviews()
        case .element:
            addSubview(view)
            view.layoutSubviews()
        }
    }
}
