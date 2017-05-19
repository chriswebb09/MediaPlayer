import UIKit

protocol CellRepresentable {
    func cellInstance(_ tableView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

