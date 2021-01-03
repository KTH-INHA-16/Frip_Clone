import UIKit

class BaseViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.NotoSans(.medium, size: 16)
        ]
        
        // Background Color
        self.view.backgroundColor = .white
        self.view.tintColor = .white
    }
}
