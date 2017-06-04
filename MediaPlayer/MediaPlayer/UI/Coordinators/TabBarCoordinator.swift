import UIKit

class TabBarCoordinator: TabCoordinator, TabDelegate {
    
    var type: CoordinatorType = .tabbar
    var tabBarController: TabBarController
    weak var delegate: CoordinatorDelegate?
    var window: UIWindow!
    var childCoordinators: [NavigationCoordinator] = []
    
    required init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    convenience init(tabBarController: TabBarController, window: UIWindow) {
        self.init(tabBarController: tabBarController)
        self.window = window
        setupChildCoordinators()
    }
    
    func setupChildCoordinators() {
        let settings = SettingsCoordinator(navigationController: UINavigationController())
        settings.tabDelegate = self
        settings.start()
        let media = MediaCollectionCoordinator(navigationController: UINavigationController())
        media.tabDelegate = self
        media.start()
        self.tabBarController.setup(with: [media.navigationController, settings.navigationController])
    }
    
    func start() {
        window.rootViewController = tabBarController
    }
    
    func tabTwoSelected(selected: Bool) {
        tabBarController.selectedIndex = 0
    }
    
    func tabOneSelected(selected: Bool) {
        tabBarController.selectedIndex = 1
    }
}
