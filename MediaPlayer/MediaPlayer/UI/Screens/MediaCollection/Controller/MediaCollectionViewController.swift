import UIKit

final class MediaCollectionViewController: UIViewController {
    
    // MARK: - Properties
    
    var buttonItem: UIBarButtonItem!
    
    weak var delegate: MediaControllerDelegate?
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var searchBar = UISearchBar() {
        didSet {
            searchBar.delegate = self
            searchBar.returnKeyType = .done
        }
    }
    
    var searchBarActive: Bool = false {
        didSet {
            if searchBarActive == true {
                navigationItem.rightBarButtonItems = []
            } else {
                if let buttonItem = buttonItem {
                    navigationItem.rightBarButtonItems = [buttonItem]
                }
            }
        }
    }
    
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var emptyView = EmptyView()
    
    var viewShown: ShowView = .empty {
        didSet {
            switch viewShown {
            case .empty:
                changeView(forView: emptyView, withView: collectionView)
            case .collection:
                changeView(forView: collectionView, withView: emptyView)
            }
        }
    }
    
    var dataSource: BaseMediaControllerDataSource {
        didSet {
            print("did set")
            if let count = dataSource.playlist?.itemCount, count > 0 {
                viewShown = .collection
            } else {
                viewShown = .empty
            }
        }
    }
    
    init(dataSource: BaseMediaControllerDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(collectionView: UICollectionView, dataSource: BaseMediaControllerDataSource, searchController: UISearchController) {
        self.init(dataSource: dataSource)
        self.collectionView = collectionView
        self.searchController = searchController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(collectionView)
        collectionView.setupCollectionView(view: view, newLayout: TrackItemsFlowLayout())
        collectionView.collectionViewRegister(viewController: self)
        view.emptyViewSetup(emptyView: emptyView)
        collectionView.delegate = self
        collectionView.dataSource = self
        getData()
        navigationController?.isNavigationBarHidden = false
        searchController.delegate = self
        title = "Music.ly"
        buttonItem = UIBarButtonItem(image: dataSource.image, style: .plain, target: self, action: #selector(navigationBarSetup))
        navigationItem.setRightBarButton(buttonItem, animated: false)
        setupSearchController()
    }
    
    func changeView(forView: UIView, withView: UIView) {
        view.sendSubview(toBack: withView)
        view.bringSubview(toFront: forView)
    }
    
    func getData() {
        dataSource.store.searchTerm = "new"
        dataSource.store.searchForTracks { playlist, error in
            self.dataSource.playlist = playlist
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
}

extension MediaCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let playlist = dataSource.playlist else { print("data"); return }
        let playerViewController = PlayerViewController(index: indexPath.row, playlist: playlist)
        navigationController?.pushViewController(playerViewController, animated: false)
    }
    
}

extension MediaCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewShown = .collection
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MediaCell
        if let playlistItem = dataSource.playlist?.playlistItem(at: indexPath.row),
            let track = playlistItem.track,
            let name = track.trackName,
            let urlString = track.artworkUrl,
            let url = URL(string: urlString) {
            let model = MediaCellViewModel(trackName: name, albumImageURL: url)
            cell.configureCell(with: model, withTime: 0)
            cell.alpha = 1
        }
        return cell
    }
    
}

// MARK: - UISearchControllerDelegate

extension MediaCollectionViewController: UISearchControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let searchBarText = searchBar.text, searchBarText.characters.count > 0 { searchBarActive = true }
    }
    
    func setupSearchController() {
        setSearchBarColor(searchBar: searchBar)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchBar.barTintColor = .white
    }
    
    func navigationBarSetup() {
        guard let navController = self.navigationController else { return }
        setupNavigationBar(navController: navController, searchController: searchController)
        searchBar.becomeFirstResponder()
    }
    
    func setupNavigationBar(navController: UINavigationController, searchController: UISearchController) {
        navController.navigationBar.barTintColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        searchController.hidesNavigationBarDuringPresentation = false
        searchBar = searchController.searchBar
        searchBar.barTintColor = .darkGray
        
        navigationItem.titleView = searchBar
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .darkGray
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
}

// MARK: - UISearchBarDelegate

extension MediaCollectionViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dataSource.playlist?.removeAll()
        searchBar.setShowsCancelButton(true, animated: true)
        searchBarActive = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setSearchBarActive() {
        self.searchBarActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBarActive = false
    }
    
    func searchBarHasInput() {
        collectionView.reloadData()
        dataSource.playlist?.removeAll()
        dataSource.store.searchForTracks { [weak self] playlist, error in
            guard let playlist = playlist, let strongSelf = self else { return }
            strongSelf.dataSource.playlist = playlist
            if playlist.itemCount <= 0 {
                strongSelf.viewShown = .empty
            }
            strongSelf.collectionView.reloadData()
            strongSelf.collectionView.performBatchUpdates ({
                DispatchQueue.main.async {
                    strongSelf.collectionView.reloadItems(at: strongSelf.collectionView.indexPathsForVisibleItems)
                    strongSelf.collectionView.isHidden = false
                }
            }, completion: { finished in
                print(finished)
            })
        }
    }
    
    func searchOnTextChange(text: String, store: MediaDataStore, navController: UINavigationController) {
        dataSource.searchTerm = text
        searchBarActive = true
        if text != "" { searchBarHasInput() }
        navController.navigationBar.topItem?.title = "Search: \(text)"
        UIView.animate(withDuration: 1.8) {
            self.collectionView.alpha = 1
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = []
        }
        if !searchBarActive {
            collectionView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let barText = searchBar.text, let navcontroller = self.navigationController else { return }
        searchOnTextChange(text: barText, store: dataSource.store, navController: navcontroller)
    }
    
    func onCancel(collectionView: UICollectionView, dataSource: BaseMediaControllerDataSource, store: MediaDataStore) {
        dataSource.resetData()
        collectionView.reloadData()
        navigationItem.setRightBarButton(buttonItem, animated: false)
        searchBarActive = false
        viewShown = .empty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        onCancel(collectionView: collectionView, dataSource: dataSource, store: dataSource.store)
    }
}

// MARK: - UISearchResultsUpdating

extension MediaCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if searchString != nil {
            dataSource.playlist?.removeAll()
            if let searchString = searchString {
                self.dataSource.searchTerm = searchString
                self.dataSource.store.searchForTracks { [weak self] tracks, error in
                    guard let strongSelf = self, let tracks = tracks else { return }
                    strongSelf.dataSource.playlist = tracks
                }
            }
        }
        collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchBarActive = true
    }
}
