import UIKit

public final class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private var playerView = PlayerView()
    var playlist: Playlist!
    var index: Int! 
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        let track = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = track?.track?.artistName
        playerView.frame = UIScreen.main.bounds
        guard let trackName = track?.track?.trackName, let imageUrl = track?.track?.artworkUrl else { return }
        let model = PlayerViewModel(title: trackName, imageUrl: imageUrl)
        playerView.configure(with: model)
        view.addSubview(playerView)
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
