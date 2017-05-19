import UIKit

protocol MediaCoordinatorDelegate: class {
    func mediCoordinator(didSelectTrackAt index: Int, withPlaylist: Playlist)
    func mediaCoordinatorDidRequestCancel(newMediaCoordinator: MediaCoordinator)
    func mediaCoordinator(newMediaCoordinator: MediaCoordinator, didAddTrack trackPayload: MediaCoordinatorPayload)
}
