//
//  Coordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol Coordinator {
    weak var delegate: CoordinatorDelegate? { get set }
    func start(viewController: UIViewController)
    
}

protocol CoordinatorDelegate: class {
    func transitionCoordinator() 
}
