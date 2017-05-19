import Foundation

public struct Track {
    
    weak var delegate: TrackDelegate?
    
    let trackName: String?
    let artistName: String?
    let artistId: Int?
    let previewUrl: String?
    let artworkUrl: String?
    let collectionName: String?
    
    
    var downloaded: Bool? {
        didSet {
            delegate?.downloadIsComplete(downloaded: (downloaded != nil))
        }
    }
    
    init?(json: [String : Any]?) {
        
        if let trackName = json?["trackName"] as? String,
            let artistName = json?["artistName"] as? String,
            let artistId = json?["artistId"] as? Int,
            let previewUrl = json?["previewUrl"] as? String,
            let artworkUrl = json?["artworkUrl100"] as? String,
            let collectionName = json?["collectionName"] as? String {
            
            self.trackName = trackName
            self.artistName = artistName
            self.artistId = artistId
            self.previewUrl = previewUrl
            self.artworkUrl = artworkUrl
            self.collectionName = collectionName
            self.downloaded = false
            
        } else {
            return nil
        }
    }
}

// MARK: - Hashable

extension Track: Hashable {
    
    public var hashValue: Int {
        guard let trackName = trackName else { return 0 }
        return trackName.hashValue
    }
    
    public static func ==(lhs: Track, rhs: Track) -> Bool {
        return lhs.previewUrl == rhs.previewUrl
    }
}
