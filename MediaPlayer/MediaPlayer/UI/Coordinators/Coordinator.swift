//
//  Coordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/24/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum CoordinatorType {
    case app, tabbar
}

protocol Coordinator {
    weak var delegate: CoordinatorDelegate? { get set }
    var type: CoordinatorType { get set }
    func start(viewController: UIViewController)
}

protocol CoordinatorDelegate: class {
    func transitionCoordinator(type: CoordinatorType)
}
