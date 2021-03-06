import UIKit

final class StartViewController: UIViewController {
    
    var startView: StartView = StartView()
    weak var delegate: StartViewControllerDelegate?
    
    init(startView: StartView = StartView()) {
        self.startView = startView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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



