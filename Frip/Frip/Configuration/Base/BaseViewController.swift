import UIKit

class BaseViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.NotoSans(.medium, size: 16)
        ]
        self.navigationController?.navigationBar.backgroundColor = .white
        self.tabBarController?.tabBar.backgroundColor = .white
    }
}
