import UIKit

class MediaDataStore: MediaCollectionHandler {
    var searchTerm: String = ""
    
    func setSearch(string: String?) {
        searchTerm = string!
    }
    
    func didSearchForTrack(with term: String) {
        print(term)
    }
    
    func searchForTracks(completion: @escaping (_ playlist: Playlist? , _ error: Error?) -> Void) {
        MediaAPIClient.search(for: searchTerm) { response in
            switch response {
            case .success(let data):
                let parser = TrackParser()
                let playlist = parser.parse(data) as! Playlist
                completion(playlist, nil)
            case .failed(let error):
                completion(nil, error)
            }
        }
    }
}
