import UIKit

final class TabBarCoordinator: TabCoordinator, TabDelegate {
    
    var type: CoordinatorType = .tabbar
    var tabBarController: TabBarController
    weak var delegate: CoordinatorDelegate?
    var dataSource: BaseMediaControllerDataSource!
    var window: UIWindow!
    var childCoordinators: [NavigationCoordinator] = []
    
    required init(tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    convenience init(tabBarController: TabBarController, window: UIWindow) {
        self.init(tabBarController: tabBarController)
        self.window = window
        self.dataSource = BaseMediaControllerDataSource(store: MediaDataStore())
        setupChildCoordinators()
    }
    
    func setupChildCoordinators() {
        let settings = SettingsCoordinator(navigationController: UINavigationController())
        settings.tabDelegate = self
        settings.start()
        var controller = MediaCollectionViewController(dataSource: dataSource)
       
        var media = MediaCollectionCoordinator(navigationController: UINavigationController(), mediaCollectionController: controller)
        self.tabBarController.setup(with: [media.navigationController, settings.navigationController])
       // media.mediaController.delegate = media
        media.start()
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

