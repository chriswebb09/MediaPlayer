import UIKit

class BaseMediaControllerDataSource {
    
    var image = #imageLiteral(resourceName: "search-button").withRenderingMode(.alwaysOriginal)
    
    var store: MediaDataStore
    var playlist: Playlist?
    var tracks: [Track]?
    
    var count: Int {
        guard let playlist = playlist else { return 0 }
        return playlist.itemCount
    }
    
    init(store: MediaDataStore) {
        self.store = store
    }
}
