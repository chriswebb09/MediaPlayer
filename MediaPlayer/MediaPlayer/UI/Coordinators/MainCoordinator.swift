import UIKit

class MainCoordinator {
    
    var appCoordinator: Coordinator
    var window: UIWindow!
    
    @discardableResult
    init(coordinator: Coordinator, window: UIWindow) {
        self.appCoordinator = coordinator
        self.window = window
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        self.appCoordinator.start(viewController: splashViewController)
        appCoordinator.delegate = self
    }
}

extension MainCoordinator: CoordinatorDelegate {
    func transitionCoordinator(type: CoordinatorType) {
        switch type {
        case .app:
            return
        case .tabbar:
            let tabbarController = TabBarController()
            let tabCoordinator = TabbarCoordinator(window: window, tabbarController: tabbarController)
            appCoordinator = tabCoordinator
            tabCoordinator.start(viewController: tabbarController)
        }
    }
}
