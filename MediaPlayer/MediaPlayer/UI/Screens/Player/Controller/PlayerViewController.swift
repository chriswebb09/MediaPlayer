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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        let track = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = track?.track?.artistName
        guard let trackName = track?.track?.trackName, let imageUrl = track?.track?.artworkUrl else { return }
        setModel(model: PlayerViewModel(title: trackName, imageUrl: imageUrl))
        view.addView(view: playerView, type: .full)
    }
    
    func setModel(model: PlayerViewModel) {
        playerView.configure(with: model)
        title = model.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.alpha = 1
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
