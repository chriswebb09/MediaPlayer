import UIKit

final class TabBarController: UITabBarController {
    
    // Accessible in Tabbar child controllers
    weak var controllerDelegate: TabControllerDelegate?
    
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
        tabBar.tintColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
    }
    
    func setControllers(mediaCollectionController: MediaCollectionViewController, settingsController: SettingsViewController) {
        UITabBar.appearance().tintColor = UIColor.orange
        let mediaCollectionTab = setupSearchTab(tracksViewController: mediaCollectionController)
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
    
    func setupSearchTab(tracksViewController: MediaCollectionViewController) -> UINavigationController {
        let normalImage = #imageLiteral(resourceName: "blue-dj")
        let selectedImage = #imageLiteral(resourceName: "orangedj")
        tracksViewController.delegate = self
        tracksViewController.tabBarItem = UITabBarItem(title: nil, image: normalImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysTemplate))
        let tracksTab = UINavigationController(rootViewController: tracksViewController)
        
        return tracksTab
    }
    
    private func setupTab(settingsViewController: SettingsViewController) -> UINavigationController {
        let selectedImage = #imageLiteral(resourceName: "orange-soundwave")
        let normalImage = #imageLiteral(resourceName: "blue-soundwave")
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
