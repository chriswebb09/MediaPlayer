import UIKit

final class MediaPlaylistViewController: BaseMediaViewController {
    
    var buttonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let playlist = dataSource.playlist else { return }
        if playlist.itemCount > 0 {
            collectionView.isHidden = false
        }
        buttonItem = UIBarButtonItem(image: dataSource.image, style: .plain, target: self, action: #selector(goToSearch))
        commonInit(buttonItem: buttonItem!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItems = [buttonItem!]
    }
    
    private func commonInit(buttonItem: UIBarButtonItem) {
        navigationItem.setRightBarButton(buttonItem, animated: false)
    }
    
    func goToSearch() {
        // implement
    }
}
