import UIKit

protocol MediaViewControllerDelegate:  class {
    func didTapClose(mediaViewController: MediaCollectionViewController)
    func didSelectPlaylistItem(at index: Int, for list: Playlist)
}
