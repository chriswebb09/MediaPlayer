import UIKit

class TabbarCoordinator: Coordinator {
    
    var type: CoordinatorType = .tabbar
    
    weak var delegate: CoordinatorDelegate?
    
    // MARK: - Properties
    
    var mediaCollectionController: MediaCollectionViewController!
    var settingsController: SettingsViewController!
    var dataSource: BaseMediaControllerDataSource!
    var window: UIWindow!
    var tabbarController: TabBarController!

    // MARK: - Init
    
    init(window: UIWindow, tabbarController: TabBarController = TabBarController()) {
        self.setStore(from: MediaAPIClient())
        var settingsView = SettingsView()
        self.settingsController = SettingsViewController(settingsView: settingsView)
        self.tabbarController = tabbarController
        setWindow(window: window)
    }
    
    func setWindow(window: UIWindow) {
        self.window = window
        self.window.rootViewController = tabbarController
        self.window.makeKeyAndVisible()
    }
    
    func setupTabController(tabController: TabBarController) {
        tabbarController.controllerDelegate = self
        tabbarController.setControllers(mediaCollectionController: mediaCollectionController, settingsController: settingsController)
    }
    
    func start(viewController: UIViewController) {
        setupTabController(tabController: tabbarController)
    }
    
    func controllerAtIndex(index: Int) {
        tabbarController.selectedIndex = index
        let navController = tabbarController.viewControllers?[0] as! UINavigationController
        navController.popViewController(animated: false)
    }
    
    func setStore(from client: MediaAPIClient) {
        let store = MediaDataStore()
        self.dataSource = BaseMediaControllerDataSource(store: store)
        let collectionView = MediaCollectionViewController(dataSource: dataSource)
        self.mediaCollectionController = collectionView
    }
}

extension TabbarCoordinator: TabControllerDelegate {
    
    func didSelectTrack(at index: Int, with playlist: Playlist) {
        let playerView = PlayerView()
        let playerViewController = PlayerViewController(playerView: playerView, index: index, playlist: playlist)
        playerViewController.playlist = playlist
        tabbarController.tabBar.alpha = 0
        mediaCollectionController.navigationController?.pushViewController(playerViewController, animated: false)
    }
}
