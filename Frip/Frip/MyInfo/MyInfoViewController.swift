

import UIKit

class MyInfoViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var isScroll: Bool = false
    var user: User = User(userIdx: 0, userNickname: "", profileImg: "", reviewCnt: 0, feedCnt: 0)
    var frips:[UserFrip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        logoutButton.cornerRadius = logoutButton.frame.width / 8
        profileImage.cornerRadius = profileImage.bounds.width * 0.5
        nameLabel.font = UIFont.NotoSans(.bold, size: 20)
        label.font = UIFont.NotoSans(.regular, size: 14)
        
        MyInfoGetDataManager().getMyInfo(targetURL: Constant.MY_PAGE, vc: self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.register(UINib(nibName: "MyInfoHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyInfoHeaderCollectionViewCell")
        collectionView.register(UINib(nibName: "NothingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NothingCollectionViewCell")
        
        MyInfoGetDataManager().getMyFrips(targetURL: Constant.MY_PAGE_FRIP, vc: self)
    }
    
    @IBAction func logOutTouchDown(_ sender: Any) {
        UserDefaults.standard.set("1", forKey: "userJWT")
        self.changeRootViewController(MainViewController())
    }
    
    func getFrips(_ result:[UserFrip]) {
        frips = result
        collectionView.reloadData()
    }
    
    func getUser(_ result: User) {
        user = result
        profileImage.kf.setImage(with: URL(string: user.profileImg))
        nameLabel.text = user.userNickname
    }

}

extension MyInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if frips.count != 0 {
                return frips.count
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyInfoHeaderCollectionViewCell", for: indexPath) as! MyInfoHeaderCollectionViewCell
            return cell
        } else {
            if frips.count != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
                cell.saveButton.isHidden = true
                cell.image.kf.setImage(with: URL(string: frips[indexPath.row].fripPhotoUrl))
                cell.place.text = frips[indexPath.row].place
                cell.point.text = frips[indexPath.row].rate
                cell.title.text = frips[indexPath.row].fripTitle
                cell.shortDescription.text = frips[indexPath.row].fripHeader
                cell.price.text = frips[indexPath.row].price
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NothingCollectionViewCell", for: indexPath) as! NothingCollectionViewCell
                cell.label.text = "신청한 프립이 존재하지 않습니다."
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.frame.width, height: 40)
        } else {
            if frips.count != 0 {
                return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
            } else {
                return CGSize(width: collectionView.frame.width , height: collectionView.frame.height + 300)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y < 0 {
            if isScroll == true {
                border.isHidden = false
                logoutButton.isHidden = false
                collectionView.frame.origin.y = collectionView.frame.origin.y + 120
                isScroll = false
            }
        } else {
            if isScroll == false {
                border.isHidden = true
                logoutButton.isHidden = true
                collectionView.frame.origin.y = collectionView.frame.origin.y - 120
                isScroll = true
            }
        }
    }
    
}
