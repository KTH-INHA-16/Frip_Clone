import UIKit

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let myInfoViewController = MyInfoViewController()
    let storedViewController = StoredViewController()
    let feedViewController = FeedViewController()
    let categoryViewController = CategoryViewController()
    let homeViewController = HomeViewController()
    
    let myinfoTabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    let storedTabBarItem = UITabBarItem(title: "저장", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
    let feedTabBarItem = UITabBarItem(title: "피드", image: UIImage(systemName: "square.split.1x2"), selectedImage: UIImage(systemName: "square.split.1x2.fill"))
    let categoryTabBarItem = UITabBarItem(title: "카테고리", image: UIImage(systemName: "line.horizontal.3"), selectedImage: UIImage(systemName: "line.horizontal.3"))
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        let myinfoNavigationController = UINavigationController(rootViewController: myInfoViewController)
        let storedNavigationController = UINavigationController(rootViewController: storedViewController)
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let categoryNavigationController = UINavigationController(rootViewController: categoryViewController)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        homeTabBarItem.tag = 0
        homeNavigationController.tabBarItem = homeTabBarItem
        
        categoryTabBarItem.tag = 1
        categoryNavigationController.tabBarItem = categoryTabBarItem
        
        feedTabBarItem.tag = 2
        feedNavigationController.tabBarItem = feedTabBarItem
        
        storedTabBarItem.tag = 3
        storedNavigationController.tabBarItem = storedTabBarItem
        
        myinfoTabBarItem.tag = 4
        myinfoNavigationController.tabBarItem = myinfoTabBarItem
        
        self.viewControllers = [ homeNavigationController, categoryNavigationController, feedNavigationController, storedNavigationController, myinfoNavigationController ]
        self.delegate = self
    }


}
