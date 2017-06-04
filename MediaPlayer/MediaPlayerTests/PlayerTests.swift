import XCTest

@testable import NewMediaPlayer
class PlayerTests: XCTestCase {
    
    var dataSource: MediaDataStore!
    var playerView: PlayerView!
    
    override func setUp() {
        self.dataSource = MediaDataStore()
        self.playerView = PlayerView()
        super.setUp()
    }
    
    override func tearDown() {
        self.dataSource = nil
        self.playerView = nil
        super.tearDown()
    }
    
//    func testPlay() {
//        dataSource.setSearch(string: "new")
//        var controller: PlayerViewController!
//        dataSource.searchForTracks { playlist, error in
//            guard let playlist = playlist else { assertionFailure(); return }
//            controller = PlayerViewController(playerView: self.playerView, index: 1, playlist: playlist)
//            controller.viewDidLoad()
//            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
//            controller.playButtonTapped()
//            XCTAssert(controller.playerState == .playing, "Player state is playing")
//        }
//    }
    
//    func testPause() {
//        dataSource.setSearch(string: "new")
//        var controller: PlayerViewController!
//        dataSource.searchForTracks { playlist, error in
//            guard let playlist = playlist else { assertionFailure(); return }
//            controller = PlayerViewController(playerView: self.playerView, index: 1, playlist: playlist)
//            controller.viewDidLoad()
//            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
//            controller.playButtonTapped()
//            controller.pauseButtonTapped()
//            XCTAssert(controller.playerState == .paused, "Player state is paused")
//        }
//    }
    
//    func testSkip() {
//        dataSource.setSearch(string: "new")
//        var controller: PlayerViewController!
//        var playerlist: Playlist!
//        dataSource.searchForTracks { playlist, error in
//            guard let playlist = playlist else { assertionFailure(); return }
//            controller = PlayerViewController(playerView: self.playerView, index: 1, playlist: playlist)
//            playerlist = playlist
//            controller.viewDidLoad()
//            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
//            controller.skipButtonTapped()
//            XCTAssert(controller.playlistItem == playerlist?.playlistItem(at: 2), "PlaylistItem is second track" )
//            XCTAssert(controller.playerState == .queued, "Track is queued")
//        }
//    }
    
}
