import UIKit

class MainCoordinator {
    
    var appCoordinator: FlowCoordinator
    var window: UIWindow!
    
    @discardableResult
    init(coordinator: FlowCoordinator, window: UIWindow?) {
        self.appCoordinator = coordinator
        self.window = window
        appCoordinator.delegate = self
    }
    
    init(window: UIWindow) {
        self.window = window
        appCoordinator = AppCoordinator(navigationController: UINavigationController(), window: window)
        appCoordinator.delegate = self
    }
    
    func start() {
        self.appCoordinator.start()
    }
}

extension MainCoordinator: CoordinatorDelegate {
    
    func transitionCoordinator(type: CoordinatorType) {
        switch type {
        case .app:
            break
        case .tabbar:
            let tabbarController = TabBarController()
            let tabbBarCoordinator = TabBarCoordinator(tabBarController: tabbarController, window: window)
            tabbBarCoordinator.delegate = self
            appCoordinator = tabbBarCoordinator
            start()
        }
    }
}
