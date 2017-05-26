import UIKit

final class StartViewController: UIViewController {
    
    var startView: StartView = StartView()
    
    weak var delegate: StartViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        startView.tag = 0
        view.addView(view: startView, type: .full)
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



