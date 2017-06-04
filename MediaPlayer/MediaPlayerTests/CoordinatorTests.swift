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
    
    override func invokeTest() {
        super.invokeTest()
        continueAfterFailure = false 
    }
    
    func testSplashCoordinator() {
        appCoordinator.start(viewController: splashViewController)
        XCTAssertEqual(appCoordinator.navigationController.viewControllers[0], splashViewController)
        XCTAssertTrue(appCoordinator.navigationController.isNavigationBarHidden)
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
        XCTAssertEqual(appCoordinator.navigationController.viewControllers[1].view.tag, 1)
        XCTAssertEqual(appCoordinator.navigationController.viewControllers[1].title, "Login")
        XCTAssertFalse(appCoordinator.navigationController.isNavigationBarHidden)
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
        XCTAssertEqual(appCoordinator.navigationController.viewControllers[1].view.tag, 3)
        XCTAssertTrue(appCoordinator.navigationController.isNavigationBarHidden)
    }
}
