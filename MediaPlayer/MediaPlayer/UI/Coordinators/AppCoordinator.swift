import UIKit

class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    
    var store = MediaDataStore(client: MediaAPIClient())
    
    let services: Services
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    fileprivate lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    // Starts the coordinator
    
    public func start() {
        self.showSplashViewController()
    }
    
    // Creates a new SplashViewController and places it into the navigation controller
    
    private func showSplashViewController() {

        let splashViewController = SplashViewController(services: services)
        splashViewController.delegate = self
        navigationController.viewControllers = [splashViewController]
    }
    
}

extension AppCoordinator: SplashViewControllerDelegate {
    func splashViewFinishedAnimation(finished: Bool) {
        let dataSource = BaseMediaControllerDataSource(store: store)
        let mediaCollectionController = MediaCollectionViewController(dataSource: dataSource)
        navigationController.viewControllers = [mediaCollectionController]
    }
}



//
//extension AppCoordinator: MediaCollectionViewControllerDelegate {
//    
//}


// MARK: - SplashViewControllerDelegate


//extension AppCoordinator: SplashCoordinatorDelegate {
//    func animationFinished(finished: Bool) {
//        print(finished)
//        let dataSource = BaseMediaControllerDataSource(store: store)
////        let mediaCoordinator = MediaCoordinator(services: self.services, dataSource: dataSource)
////        mediaCoordinator.delegate = self
////        mediaCoordinator.start()
////        addChildCoordinator(mediaCoordinator)
////        rootViewController.present(mediaCoordinator.rootViewController, animated: false, completion: nil)
//    }
//
//    
//}

//extension AppCoordinator: SplashViewControllerDelegate {
//    
//    func splashViewFinishedAnimation(finished: Bool) {
//        let dataSource = BaseMediaControllerDataSource(store: store)
//        let mediaCoordinator = MediaCoordinator(services: self.services, dataSource: dataSource)
//        mediaCoordinator.delegate = self
//        mediaCoordinator.start()
//        addChildCoordinator(mediaCoordinator)
//        rootViewController.present(mediaCoordinator.rootViewController, animated: false, completion: nil)
//    }
//    
//    
//    func splashViewControllerDidTapNewOrder(splashViewController: SplashViewController) {
//        let dataSource = BaseMediaControllerDataSource(store: store)
//        let mediaCoordinator = MediaCoordinator(services: self.services, dataSource: dataSource)
//        mediaCoordinator.delegate = self
//        mediaCoordinator.start()
//        addChildCoordinator(mediaCoordinator)
//        rootViewController.present(mediaCoordinator.rootViewController, animated: false, completion: nil)
//    }
//    
//}

// MARK: - MediaCoordinatorDelegate
//
//extension AppCoordinator: MediaCoordinatorDelegate {
//    
//    func mediCoordinator(didSelectTrackAt index: Int, withPlaylist: Playlist) {
//        let dataSource = BaseMediaControllerDataSource(store: store)
//        let mediaCoordinator = MediaCoordinator(services: self.services, dataSource: dataSource)
//        mediaCoordinator.delegate = self
//        mediaCoordinator.start()
//        addChildCoordinator(mediaCoordinator)
//        rootViewController.present(mediaCoordinator.rootViewController, animated: false, completion: nil)
//    }
//    
//    
//    func mediaCoordinatorDidRequestCancel(newMediaCoordinator mediaCoordinator: MediaCoordinator) {
//        mediaCoordinator.rootViewController.dismiss(animated: true)
//        self.removeChildCoordinator(mediaCoordinator)
//    }
//}
//



