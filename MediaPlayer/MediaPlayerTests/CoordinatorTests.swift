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
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is hidden")
    }
    
    func testStartCoordinator() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        XCTAssert(appCoordinator.navigationController.viewControllers[0].view.tag == 0, "View is of type startView / tag == 0")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is hidden")
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
        XCTAssert(appCoordinator.navigationController.viewControllers[1].title == "Login", "Controller title is Login")
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == false, "Navigation bar is visible")
    }
    
    func testGoFromLogin() {
        let appCoordinator = AppCoordinator(window: UIWindow())
        let mainCoordinator = MainCoordinator(coordinator: appCoordinator)
        let splashView = SplashView()
        let splashViewController = SplashViewController(splashView: splashView)
        mainCoordinator.appCoordinator.start(viewController: splashViewController)
        //appCoordinator.start(viewController:splashViewController)
        appCoordinator.splashViewFinishedAnimation(finished: true)
        let startVC = appCoordinator.navigationController.viewControllers[0] as! StartViewController
        startVC.loginTapped()
        let loginVC = appCoordinator.navigationController.viewControllers[1] as! LoginViewController
        loginVC.submitButtonTapped()
        var test = mainCoordinator.appCoordinator
        
        print(test)
        
       // let tabCoord = mainCoordinator.appCoordinator as! TabbarCoordinator
        //XCTAssert(tabCoord.tabbarController != nil)
    //    XCTAssert(appCoordinator.navigationController.viewControllers[1].view.tag == 1, "View is of type LoginView / tag == 1")
      //  XCTAssert(appCoordinator.navigationController.viewControllers[1].title == "Music.ly", "Controller title is Login")
        //XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == false, "Navigation bar is visible")
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
        XCTAssert(appCoordinator.navigationController.isNavigationBarHidden == true, "Navigation bar is visible")
    }
}
