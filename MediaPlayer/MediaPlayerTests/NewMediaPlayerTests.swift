import XCTest

@testable import NewMediaPlayer
class MediaPlayerTests: XCTestCase {
    
    var store: MediaDataStore!
    var dataSource: BaseMediaControllerDataSource!
    
    override func setUp() {
        self.store = MediaDataStore()
        self.dataSource = BaseMediaControllerDataSource(store: store)
        super.setUp()
    }
    
    override func tearDown() {
        self.store = nil
        self.dataSource = nil
        super.tearDown()
    }
    
    func testSetStoreSearchTerm() {
        let mediaStore = MediaDataStore()
        mediaStore.setSearch(string: "New")
        XCTAssert(mediaStore.searchTerm == "New", "Sets search term to new")
    }
    
    func testDataSourceOverridesSearchTerm() {
        store.setSearch(string: "new")
        XCTAssert(store.searchTerm == "new")
        dataSource.searchTerm = ""
        XCTAssert(store.searchTerm == "")
    }
    
    func testDataSourceResets() {
        let playlist = Playlist()
        let newItem = PlaylistItem()
        playlist.append(newPlaylistItem: newItem)
        dataSource.playlist = playlist
        dataSource.resetData()
        XCTAssert(playlist.itemCount == 0)
        XCTAssert(dataSource.playlist?.itemCount == 0)
    }
    
    func testDataSourceSetsSearchTerm() {
        dataSource.searchTerm = ""
        XCTAssert(store.searchTerm == "")
    }
    
    func testUrlConstructor() {
        let testTerm = "hello"
        guard let url = URLConstructor().build(searchTerm: testTerm) else { return }
        XCTAssert(url.absoluteString == "https://itunes.apple.com/search?media=music&entity=song&term=hello" , "URL is properly constructed")
    }
    
    func testEmailFormat() {
        var email = "chris@gmail.com"
        XCTAssert(email.isValidEmail() == true, "Email is properly formatted")
        email = "chris.com"
        XCTAssert(email.isValidEmail() == false, "Email is properly formatted")
    }
}
