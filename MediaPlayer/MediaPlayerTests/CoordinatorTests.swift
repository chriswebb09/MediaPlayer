import XCTest

@testable import NewMediaPlayer
class CoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSplashCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController =  SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        XCTAssert(appCoordinator.navigationController.viewControllers[0] == splashViewController, "Navigation viewcontrollers is StartViewController")
    }
    
    func testStartCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        XCTAssert(appCoordinator.navigationController.viewControllers[0].view.tag == 0, "View is of type startView / tag == 0")
    }
    
    func testGoToLogin() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.loginTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 1, "View is of type LoginView / tag == 1")
    }
    
    func testGoToCreateAccount() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.createAccountTapped()
        XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 3, "View is of type startView / tag == 0")
    }
}
