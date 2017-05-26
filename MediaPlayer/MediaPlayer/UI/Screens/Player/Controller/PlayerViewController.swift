import UIKit

final class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private var playerView: PlayerView!
    
    var playlist: Playlist!
    var index: Int!
    var playerViewModel: PlayerViewModel!
    var track: Track!
    var playlistItem: PlaylistItem!
    
    init(playerView: PlayerView = PlayerView()) {
        self.playerView = playerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        playlistItem = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = playlistItem.track?.artistName
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
        view.addView(view: playerView, type: .full)
    }
    
    func setModel(model: PlayerViewModel) {
        playerView.configure(with: model)
        title = model.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController?.tabBar.alpha = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.alpha = 1
    }
}

extension PlayerViewController: PlayerViewDelegate {
    
    func backButtonTapped() {
        guard let previous = playlistItem.previous else { return }
        self.playlistItem = previous
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
    }

    func skipButtonTapped() {
        guard let next = playlistItem.next else { return }
        self.playlistItem = next
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
    }

    func pauseButtonTapped() {
        print("pause")
    }

    func playButtonTapped() {
        print("play")
    }
}
