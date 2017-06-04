import UIKit

class BaseMediaViewController: UIViewController, UICollectionViewDataSource {
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
  //  weak var delegate: MediaControllerDelegate?
    
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
    
    func changeView(forView: UIView, withView: UIView) {
        view.sendSubview(toBack: withView)
        view.bringSubview(toFront: forView)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(collectionView)
        collectionView.setupCollectionView(view: view, newLayout: TrackItemsFlowLayout())
        collectionView.collectionViewRegister(viewController: self)
        view.emptyViewSetup(emptyView: emptyView)
        getData()
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
