//
//  CoordinatorFactory.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
    func makePlayerCoordinator() -> Coordinator
    func makePlayerCoordinator(navController: UINavigationController?) -> Coordinator
}


final class CoordinatorBuilder: CoordinatorFactory {
    func makePlayerCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator  = MediaCoordinator(services: Services(), dataSource: BaseMediaControllerDataSource(store: MediaDataStore(client: MediaAPIClient())))
        return coordinator
    }
    
    func makePlayerCoordinator() -> Coordinator {
        return makePlayerCoordinator(navController: nil)
    }
    
    func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?) {
        let controller = TabbarController()
        let coordinator = TabbarCoordinator(tabbarView: controller)
        return (coordinator, controller)
    }
}
