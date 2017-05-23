import UIKit

public class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    
    var playerView = PlayerView()
    var playlist: Playlist!
    var index: Int! 
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        let track = playlist.playlistItem(at: index)
        edgesForExtendedLayout = []
        title = track?.track?.artistName
        playerView.frame = UIScreen.main.bounds
        let model = PlayerViewModel(title: "Test", imageUrl: "Test 2")
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
