import UIKit

protocol MediaControllerDelegate: class {
    func didSelectTrackAt(at index: Int, with playlist: Playlist)
}


