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
        mediaCollectionController.delegate = self
        navigationController.viewControllers = [mediaCollectionController]
    }
}

extension AppCoordinator: MediaControllerDelegate {
    
    func didSelectTrackAt(at index: Int, with playlist: Playlist) {
        let playerViewController = PlayerViewController()
        playerViewController.index = index
        playerViewController.playlist = playlist
        navigationController.pushViewController(playerViewController, animated: false)
    }
}


