//
//  TabBarCoordinator.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    var childViewControllers: [UIViewController] { get set }
    
    init(navigationController: UINavigationController)
}

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    
    init(tabBarController: UITabBarController)
}
