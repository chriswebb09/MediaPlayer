import UIKit

public struct Tabbar {
    public static let tint = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
    public static let tabbarFrameHeight: CGFloat = 0.09
}

struct TabbarConstants {
    static let navXYOrigin: CGFloat = 0
    static let navHeightMultiplier: CGFloat = 1.2
}

final class TabBarController: UITabBarController {
    
    // Accessible in Tabbar child controllers
    weak var controllerDelegate: TabControllerDelegate?
    var store: BaseMediaControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTabBar(tabBar: tabBar, view: view)
    }
    
    // General dimensions and look of tabbar
    
    private func setupTabBar(tabBar: UITabBar, view: UIView) {
        var tabFrame = tabBar.frame
        let tabBarHeight = view.frame.height * Tabbar.tabbarFrameHeight
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.isTranslucent = true
    }
    
    func setControllers(mediaCollectionController: MediaCollectionViewController, collectionNav: UINavigationController, settingsController: SettingsViewController) {
        UITabBar.appearance().tintColor = UIColor.orange
        let mediaCollectionTab = setupSearchTab(tracksViewController: mediaCollectionController, navController: collectionNav)
        let playlistTab = setupTab(settingsViewController: settingsController)
        let controllers = [mediaCollectionTab, playlistTab]
        setTabTitles(controllers: controllers)
    }
    
    private func setTabTitles(controllers: [UINavigationController]) {
        viewControllers = controllers
        tabBar.items?[0].title = "Tracks"
        tabBar.items?[1].title = "Playlist"
        selectedIndex = 0
    }
    
    func setupSearchTab(tracksViewController: MediaCollectionViewController, navController: UINavigationController) -> UINavigationController {
        let normalImage = #imageLiteral(resourceName: "blue-dj")
        let selectedImage = #imageLiteral(resourceName: "orangedj")
       // let dataSource = ListControllerDataSource(store: store!)
        //dataSource.store = self.store!
      //  tracksViewController.dataSource = dataSource
       // tracksViewController.delegate = self
        tracksViewController.tabBarItem = UITabBarItem(title: nil, image: normalImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysTemplate))
        navController.viewControllers = [tracksViewController]
        let tracksTab = navController
        return tracksTab
    }
    
    private func setupTab(settingsViewController: SettingsViewController) -> UINavigationController {
        let selectedImage = #imageLiteral(resourceName: "orange-soundwave")
        let normalImage = #imageLiteral(resourceName: "blue-soundwave")
       // let dataSource = ListControllerDataSource(store: store!)
       // dataSource.store = store!
       // playlistViewController.dataSource = dataSource
        settingsViewController.tabBarItem = UITabBarItem(title: nil, image: normalImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysTemplate))
        settingsViewController.tabBarItem.selectedImage = selectedImage
        let playlistTab = UINavigationController(rootViewController: settingsViewController)
        return playlistTab
    }
}

extension TabBarController: MediaControllerDelegate {
    func didSelectTrackAt(at index: Int, with playlist: Playlist) {
        print(index)
        controllerDelegate?.didSelectTrack(at: index, with: playlist)
    }

    
}


protocol TabControllerDelegate: class {
     func didSelectTrack(at index: Int, with playlist: Playlist)
}
