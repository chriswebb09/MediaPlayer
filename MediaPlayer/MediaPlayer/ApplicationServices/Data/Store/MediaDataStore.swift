import UIKit

class MediaDataStore: MediaCollectionHandler {
    
    let networkService: NetworkService!
    var searchTerm: String = ""
    
    init(service: NetworkService) {
        self.networkService = service
    }
    
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
