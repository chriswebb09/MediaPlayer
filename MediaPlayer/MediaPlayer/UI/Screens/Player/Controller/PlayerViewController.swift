import UIKit

final class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private var playerView: PlayerView!
    var playlist: Playlist!
    var index: Int!
    
    var playerViewModel: PlayerViewModel!
    
    init(playerView: PlayerView = PlayerView()) {
        self.playerView = playerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        let track = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = track?.track?.artistName
        playerView.frame = UIScreen.main.bounds
        guard let trackName = track?.track?.trackName, let imageUrl = track?.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, imageUrl: imageUrl))
        playerView.configure(with: playerViewModel)
        view.addSubview(playerView)
    }
    
    func setModel(model: PlayerViewModel) {
        playerView.configure(with: model)
        title = model.title
    }
}

extension PlayerViewController: PlayerViewDelegate {
    
    func backButtonTapped() {
        // implement
    }

    func skipButtonTapped() {
        // implement
    }

    func pauseButtonTapped() {
       // implement
    }

    func playButtonTapped() {
        // implement
    }
}
