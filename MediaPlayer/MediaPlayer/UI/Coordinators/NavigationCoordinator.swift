//
//  NavigationCoordinator.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/29/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TabCoordinator: FlowCoordinator {
    var tabBarController: TabBarController { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    init(tabBarController: TabBarController)
}

protocol NavigationCoordinator: FlowCoordinator {
    var navigationController: UINavigationController { get set }
    var childViewControllers: [UIViewController] { get set }
    init(navigationController: UINavigationController)
}
