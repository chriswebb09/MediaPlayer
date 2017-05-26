//
//  SplashViewController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    weak var delegate: SplashViewControllerDelegate?
    
    private let splashView: SplashView!
    
    init(splashView: SplashView) {
        self.splashView = splashView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView.delegate = self
        view.addView(view: splashView, type: .full)
        view.backgroundColor = .purple
        splashView.zoomAnimation {
            print("animation")
        }
    }
    
}

extension SplashViewController: SplashViewDelegate {
    
    func animationHasCompleted() {
        animate()
    }
    
    func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dump(self.delegate)
            self.delegate?.splashViewFinishedAnimation(finished: true)
        }
    }
}
