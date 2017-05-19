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
    
    private let services: Services
    
    public init(services: Services) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        animate()
    }
    
    func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.splashViewFinishedAnimation(finished: true)
        }
    }
}
