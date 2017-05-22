//
//  SplashViewController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

public class SplashViewController: UIViewController {
    
    weak var delegate: SplashViewControllerDelegate?
    
    let splashView = SplashView()
    
    private let services: Services
    
    public init(services: Services) {
        self.services = services
        dump(delegate)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        splashView.delegate = self
        splashView.frame = UIScreen.main.bounds
        view.addSubview(splashView)
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
