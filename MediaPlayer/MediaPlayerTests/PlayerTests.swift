import XCTest

@testable import NewMediaPlayer
class PlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPlay() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        var controller: PlayerViewController!
        dataSource.searchForTracks { playlist, error in
            guard let playlist = playlist else { return }
            controller = PlayerViewController(playerView: playerView, index: 1, playlist: playlist)
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
            controller.playButtonTapped()
            XCTAssert(controller.playerState == .playing, "Player state is playing")
        }
    }
    
    func testPause() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        var controller: PlayerViewController!
        dataSource.searchForTracks { playlist, error in
            guard let playlist = playlist else { return }
            controller = PlayerViewController(playerView: playerView, index: 1, playlist: playlist)
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
            controller.playButtonTapped()
            controller.pauseButtonTapped()
            XCTAssert(controller.playerState == .paused, "Player state is paused")
        }
    }
    
    func testSkip() {
        let client = MediaAPIClient()
        let networkService = NetworkService(provider: client)
        let dataSource = MediaDataStore(service: networkService)
        dataSource.setSearch(string: "new")
        let playerView = PlayerView()
        var controller: PlayerViewController!
        var playerlist: Playlist!
        dataSource.searchForTracks { playlist, error in
            guard let playlist = playlist else { return }
            controller = PlayerViewController(playerView: playerView, index: 1, playlist: playlist)
            playerlist = playlist
            controller.viewDidLoad()
            XCTAssert(controller.playlistItem == playlist.playlistItem(at: 1), "PlaylistItem is first track" )
            controller.skipButtonTapped()
            XCTAssert(controller.playlistItem == playerlist?.playlistItem(at: 2), "PlaylistItem is second track" )
            XCTAssert(controller.playerState == .queued, "Track is queued")
        }
    }
    
}
