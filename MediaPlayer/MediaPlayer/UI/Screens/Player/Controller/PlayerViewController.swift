import UIKit

protocol Playable {
    var playlist: Playlist { get set }
    var index: Int { get set }
    var playlistItem: PlaylistItem! { get set }
}

final class PlayerViewController: UIViewController, Playable {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private var playerView: PlayerView!
    var playerState: PlayState!
    var playlist: Playlist
    var index: Int
    var playerViewModel: PlayerViewModel!
    var playlistItem: PlaylistItem!
    
    init(playerView: PlayerView = PlayerView(), index: Int, playlist: Playlist) {
        self.playerView = playerView
        self.index = index
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
        playerState = .queued
        self.playlistItem = playlist.playlistItem(at: index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        edgesForExtendedLayout = []
        title = playlistItem.track?.artistName
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
        view.addView(view: playerView, type: .full)
        playerState = .queued
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
        if index > 0 { index -= 1 }
        self.playlistItem = previous
        playerState = .queued 
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
    }

    func skipButtonTapped() {
        guard let item = playlistItem, let next = item.next else { return }
        index += 1
        self.playlistItem = next
        playerState = .queued
        guard let trackName = playlistItem.track?.trackName, let imageUrl = playlistItem.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, timer: nil, progressIncrementer: 0, time: 0, progress: 0, imageUrl: imageUrl))
    }

    func pauseButtonTapped() {
        playerState = .paused 
        print("pause")
    }

    func playButtonTapped() {
        playerState = .playing
        print("play")
    }
}
