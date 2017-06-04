import UIKit

class AppCoordinator: NavigationCoordinator {
    
    weak var delegate: CoordinatorDelegate?
    var window: UIWindow!
    var navigationController: UINavigationController
    var childViewControllers: [UIViewController] = []
    
    required init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        childViewControllers = navigationController.viewControllers
    }
    
    convenience init(navigationController: UINavigationController, window: UIWindow?) {
        self.init(navigationController: navigationController)
        guard let window = window else { fatalError("Window object not created") }
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        showSplashViewController(splashViewController: splashViewController)
    }
    
    fileprivate func showSplashViewController(splashViewController: SplashViewController) {
        splashViewController.delegate = self
        childViewControllers = [splashViewController]
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
    
    func createAccountSelected() {
        let createAccountViewController = CreateAccountViewController()
        createAccountViewController.delegate = self
        navigationController.pushViewController(createAccountViewController, animated: false)
    }
    
    func continueAsGuestSelected() {
        delegate?.transitionCoordinator(type: .tabbar)
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

