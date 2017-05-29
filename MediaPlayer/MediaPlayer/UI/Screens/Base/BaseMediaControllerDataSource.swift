import UIKit

enum MediaResultsStatus {
    case none, loading, loaded
}

enum ShowView {
    case collection, empty
}


class BaseMediaControllerDataSource {
    
    var image = #imageLiteral(resourceName: "search-button").withRenderingMode(.alwaysOriginal)
    
    var store: MediaDataStore {
        didSet {
            print(store)
        }
    }
    var playlist: Playlist? {
        didSet {
            dump(resultsStatus)
        }
    }
    
    var tracks: [Track]?
    var resultsStatus: MediaResultsStatus! {
        didSet {
            print(resultsStatus)
        }
    }
    
    var count: Int {
        guard let playlist = playlist else { return 0 }
        if playlist.itemCount > 0 {
            resultsStatus = .loaded
        }
        return playlist.itemCount
    }
    
    init(store: MediaDataStore) {
        self.store = store
        self.resultsStatus = .none
    }
}
