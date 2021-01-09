import UIKit

class HostMainViewController: UIViewController {

    var hostIdx: Int = 0
    var showOption: Int = 0
    var frips:[Frip] = []
    var comments:[FripComment] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(hostIdx: Int) {
        self.hostIdx = hostIdx
        super.init(nibName: "HostMainViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HostCollectionViewCell")
        collectionView.register(UINib(nibName: "HostTextCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HostTextCollectionViewCell")
        collectionView.register(UINib(nibName: "CommentShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommentShowCollectionViewCell")
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }

}

extension HostMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < 2 {
            return 1
        } else if section == 2{
            return 2
        } else {
            if showOption == 0{
                return frips.count
            } else {
                return comments.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 120)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 100)
        case 2:
            return CGSize(width: collectionView.frame.width / 2, height: 45)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 30)
        default:
            return CGSize(width: collectionView.frame.width, height: 0)
        }
    }
}
