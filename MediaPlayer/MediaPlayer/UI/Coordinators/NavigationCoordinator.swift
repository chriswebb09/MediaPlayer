//
//  NavigationCoordinator.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/29/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol FlowCoordinator { }

protocol NavigationCoordinator: FlowCoordinator {
    var navigationController: UINavigationController { get set }
    var childViewControllers: [UIViewController] { get set }
    init(navigationController: UINavigationController)
}

protocol TabBarCoordinator: FlowCoordinator {
    var tabBarController: UITabBarController { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    init(tabBarController: UITabBarController)
}


class MediaDisplayCoordinator: NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childViewControllers: [UIViewController] = []
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.viewControllers = childViewControllers
    }
}

