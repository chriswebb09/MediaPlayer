import XCTest

@testable import NewMediaPlayer
class MediaViewControllerTests: XCTestCase {
    
    var store: MediaDataStore!
    var dataSource: BaseMediaControllerDataSource!
    var mediaCollectionController: MediaCollectionViewController!
    
    override func setUp() {
        self.store = MediaDataStore()
        self.dataSource = BaseMediaControllerDataSource(store: store)
        self.mediaCollectionController = MediaCollectionViewController(dataSource: dataSource)
        super.setUp()
    }
    
    override func tearDown() {
        self.store = nil
        self.dataSource = nil
        self.mediaCollectionController = nil
        super.tearDown()
    }
    
    func testMediaCollectionSetsSearchTerm() {
        let navigationController = UINavigationController(rootViewController: mediaCollectionController)
        mediaCollectionController.searchOnTextChange(text: "new", store: store, navController: navigationController)
        XCTAssertEqual(store.searchTerm, "new")
    }
    
    func testMediaCollectionSetsCancel() {
        let term = "new"
        let searchController = UISearchController(searchResultsController: nil)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        var searchBar = UISearchBar()
        mediaCollectionController = MediaCollectionViewController(collectionView: collectionView, dataSource: dataSource, searchController: searchController)
        let navigationController = UINavigationController(rootViewController: mediaCollectionController)
        searchController.delegate = mediaCollectionController
        searchBar.delegate = mediaCollectionController
        searchBar = searchController.searchBar
        mediaCollectionController.searchOnTextChange(text: term, store: store, navController: navigationController)
        mediaCollectionController.onCancel(collectionView: collectionView, dataSource: dataSource, store: store)
        XCTAssertEqual(dataSource.searchTerm, "")
    }
    
    func testMediaControllerNavItemOnActive() {
        let searchController = UISearchController(searchResultsController: nil)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        mediaCollectionController = MediaCollectionViewController(collectionView: collectionView, dataSource: dataSource, searchController: searchController)
        mediaCollectionController.setSearchBarActive()
        XCTAssertEqual(mediaCollectionController.navigationItem.rightBarButtonItems?.count, 0)
    }
}
