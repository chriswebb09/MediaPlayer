import UIKit

class MediaDataStore: MediaCollectionHandler {
    
    var client: MediaAPIClient
    var searchTerm: String = ""
    var items: [Int] = []
    
    init(client: MediaAPIClient) {
        self.client = client
    }
    
    func setSearch(string: String?) {
        searchTerm = string!
    }
    
    func didSearchForTrack(with term: String) {
        print(term)
    }
    
    func addItems() {
        for i in 0..<5 {
            items.append(i)
        }
    }
    
    
    func searchForTracks(completion: @escaping (_ playlist: Playlist? , _ error: Error?) -> Void) {
       
        MediaAPIClient.search(for: searchTerm) { response in
            switch response {
            case .success(let data):
                let tracksData = data["results"] as! [[String: Any]]
                let playlist: Playlist? = Playlist()
                tracksData.forEach {
                    let track = Track(json: $0)
                    let newItem: PlaylistItem? = PlaylistItem()
                    newItem?.track = track
                    playlist?.append(newPlaylistItem: newItem)
                }
                completion(playlist, nil)
            case .failed(let error):
                completion(nil, error)
            }
        }
    }
}
