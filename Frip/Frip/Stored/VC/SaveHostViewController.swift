import UIKit

class SaveHostViewController: BaseViewController {
    
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var saveHost: [SaveHost] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoneCollectionViewCell")
        collectionView.register(UINib(nibName: "HostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HostCollectionViewCell")
        
        DispatchQueue.global(qos: .userInitiated).sync {
            StoredGetManager().getUserHosts(targetURL: Constant.HOST_LIKE, header: jwt, vc: self)
        }
        print("saveHost")
    }
    
    func getHosts(_ result:[SaveHost]) {
        for r in result {
            saveHost.append(r)
        }
        indicator.isHidden = true
        collectionView.reloadData()
    }

}

extension SaveHostViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if saveHost.count != 0 {
            return saveHost.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if saveHost.count != 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostCollectionViewCell", for: indexPath) as? HostCollectionViewCell else {
                return UICollectionViewCell()
            }
            if saveHost.count != 0 {
                cell.tag = indexPath.row
                let host = saveHost[indexPath.row]
                cell.save = true
                cell.hostIdx = host.hostIdx
                cell.hostNameLabel.text = host.hostName
                let url = URL(string: host.hostProfileImg)
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                cell.save = true
                cell.bookmarkButton.tintColor = UIColor.saveColor
                cell.image.kf.setImage(with: url)
                cell.hostCountLabel.text = "프립\(host.hostFripCnt) | 후기\(host.hostReviewCnt) | 저장\(host.hostLikeCnt)"
                cell.hostCountLabel.sizeToFit()
                cell.border.backgroundColor = .lightGray
            }
            cell.bookmarkButton.addTarget(self, action: #selector(hostTap(_:)), for: .touchDown)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoneCollectionViewCell", for: indexPath) as? NoneCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label1.text = "아직 저장한 호스트가 없어요."
            cell.label2.text = "관심있는 호스트를 저장해 보세요!"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if saveHost.count != 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! HostCollectionViewCell
            let vc = HostMainViewController(hostIdx: cell.hostIdx)
            vc.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if saveHost.count != 0 {
            return CGSize(width: collectionView.frame.width, height: 85)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
 
    @objc func hostTap(_ sender: UIButton!) {
        let idx = sender.tag
        saveHost.remove(at: idx)
        collectionView.reloadData()
    }
    
}
