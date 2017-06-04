import UIKit

protocol PlayerViewControllerDelegate: class {
    func playButtonTapped()
    func pauseButtonTapped()
    func skipButtonTapped()
}
