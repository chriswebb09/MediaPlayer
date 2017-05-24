import UIKit

class AppCoordinator {
    
    // MARK: - Properties
    
    var store = MediaDataStore(client: MediaAPIClient())
    let services: Services
    
    let dataSource: BaseMediaControllerDataSource
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        self.dataSource = BaseMediaControllerDataSource(store: store)
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    // Starts the coordinator
    
    public func start(viewController: UIViewController) {
        self.showSplashViewController(splashViewController: viewController as! SplashViewController)
    }
    
    // Creates a new SplashViewController and places it into the navigation controller
    
    private func showSplashViewController(splashViewController: SplashViewController) {
        splashViewController.delegate = self
        navigationController.viewControllers = [splashViewController]
    }
}

extension AppCoordinator: SplashViewControllerDelegate {
    
    func splashViewFinishedAnimation(finished: Bool) {
        let startViewController = StartViewController()
        startViewController.delegate = self
        navigationController.viewControllers = [startViewController]
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

extension AppCoordinator: StartViewControllerDelegate {
    
    func loginSelected() {
        let loginViewController = LoginViewController()
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func continueAsGuestSelected() {
        let mediaCollectionController = MediaCollectionViewController(dataSource: dataSource)
        mediaCollectionController.delegate = self
        navigationController.viewControllers = [mediaCollectionController]
    }
    
    func createAccountSelected() {
        
    }
}


