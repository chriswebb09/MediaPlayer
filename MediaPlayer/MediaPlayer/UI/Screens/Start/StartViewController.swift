import UIKit

class StartViewController: UIViewController {
    
    var startView: StartView = StartView()
    
    weak var delegate: StartViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        startView.frame = UIScreen.main.bounds
        view.addSubview(startView)
        startView.layoutSubviews()
        startView.delegate = self
    }
}

extension StartViewController: StartViewDelegate {

    func continueAsGuestTapped() {
        delegate?.continueAsGuestSelected()
    }
    
    func createAccountTapped() {
        delegate?.createAccountSelected()
    }
    
    func loginTapped() {
        delegate?.loginSelected()
    }
}
