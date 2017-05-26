import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var store = MediaDataStore(service: NetworkService(provider: MediaAPIClient()))
    
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
    
    init(window: UIWindow) {
        self.window = window
        self.dataSource = BaseMediaControllerDataSource(store: store)
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    // Starts the coordinator
    
    func start(viewController: UIViewController) {
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

extension AppCoordinator: StartViewControllerDelegate {
    
    func loginSelected() {
        let loginViewController = LoginViewController()
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func continueAsGuestSelected() {
        let tabbarController = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabCoordinator = TabbarCoordinator(window: window, tabbarController: tabbarController)
        appDelegate.mainCoordinator.appCoordinator = tabCoordinator
        tabCoordinator.start(viewController: tabbarController)
    }
    
    func createAccountSelected() {
        print("Create account")
    }
}


