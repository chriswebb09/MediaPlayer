import UIKit

class AppCoordinator: Coordinator {
    
    var type: CoordinatorType = .app
    
    weak var delegate: CoordinatorDelegate?
    
    // MARK: - Properties
    
    var store = MediaDataStore()
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
    
    init(window: UIWindow?) {
        guard let window = window else { fatalError("Window object not created") }
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
        let loginView = LoginView()
        let loginModel = LoginViewModel()
        loginView.configure(model: loginModel)
        let loginViewController = LoginViewController(loginView: loginView)
        loginViewController.delegate = self
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func continueAsGuestSelected() {
        delegate?.transitionCoordinator(type: .tabbar)
    }
    
    func createAccountSelected() {
        let createAccountViewController = CreateAccountViewController()
        createAccountViewController.delegate = self
        navigationController.pushViewController(createAccountViewController, animated: false)
    }
}

extension AppCoordinator: LoginViewControllerDelegate {
    
    func loginButtonTapped() {
        delegate?.transitionCoordinator(type: .tabbar)
    }
}

extension AppCoordinator: CreateAccountViewControllerDelegate {
    
    func submitButtonTapped() {
        delegate?.transitionCoordinator(type: .tabbar)
    }
}

