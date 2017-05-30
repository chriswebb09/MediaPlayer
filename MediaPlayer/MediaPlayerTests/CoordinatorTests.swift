import XCTest

@testable import NewMediaPlayer
class CoordinatorTests: XCTestCase {
    
    var appCoordinator: AppCoordinator!
    var splashView: SplashView!
    var splashViewController: SplashViewController!
    
    override func setUp() {
        self.splashView = SplashView()
        self.splashViewController = SplashViewController(splashView: splashView)
        self.appCoordinator = AppCoordinator(window: UIWindow())
        super.setUp()
    }
    
    override func tearDown() {
        splashView = nil
        splashViewController = nil
        appCoordinator = nil
        super.tearDown()
    }
    
    func testSplashCoordinator() {
        appCoordinator.start(viewController: splashViewController)
        XCTAssert(appCoordinator.navigationController.viewControllers[0] == splashViewController, "Navigation viewcontrollers is StartViewController")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is hidden")
    }
    
    func testStartCoordinator() {
        let mainCoordinator = MainCoordinator(coordinator: appCoordinator, window: appCoordinator.window)
        appCoordinator.start(viewController: splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        XCTAssert(appCoordinator.navigationController.viewControllers[0].view.tag == 0, "View is of type startView / tag == 0")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is hidden")
        XCTAssert(mainCoordinator.appCoordinator.type == .app, "Application coordinator is App coordinator")
    }
    
    func testGoToLogin() {
        appCoordinator.start(viewController: splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.loginTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 1, "View is of type LoginView / tag == 1")
        XCTAssert(appCoordinator.navigationController.viewControllers[1].title == "Login", "Controller title is Login")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == false, "Navigation bar is visible")
    }
    
    func testGoFromLogin() {
        let mainCoordinator = MainCoordinator(coordinator: appCoordinator, window: appCoordinator.window)
        mainCoordinator.appCoordinator.start(viewController: splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.loginTapped()
        let loginVC = appCoordinator.navigationController.viewControllers[1] as! LoginViewController
        loginVC.submitButtonTapped()
        XCTAssert(mainCoordinator.appCoordinator.type == .tabbar, "Application goes to tabbar")
    }
    
    func testGoToCreateAccount() {
        appCoordinator.start(viewController: splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.createAccountTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 3, "View is of type createAccountView / tag == 3")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is visible")
    }
}
