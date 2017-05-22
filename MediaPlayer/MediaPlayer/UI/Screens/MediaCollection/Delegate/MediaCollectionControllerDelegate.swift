import UIKit

public protocol MediaCollectionControllerDelegate: class {
    func playerViewControllerDidTapClose(_ playerViewController: PlayerViewController)
    func playerViewController(_ playerViewController: PlayerViewController, didSelectMediaType mediaType: String)
}
