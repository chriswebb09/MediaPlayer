import Foundation

final class MediaCellViewModel: MediaCellModeler {
    
    var trackName: String
    var albumImageUrl: URL
    
    init(trackName: String, albumImageURL: URL) {
        self.trackName = trackName
        self.albumImageUrl = albumImageURL
    }
}
