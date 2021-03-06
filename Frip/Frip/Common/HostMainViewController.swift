import UIKit

class HostMainViewController: BaseViewController {

    let buttonText: [String] = ["프립","후기"]
    var hostIdx: Int = 0
    var showOption: Int = 0
    var hostInfo: HostInfo?
    var host: HostInfo {
        set(newValue) { hostInfo = newValue }
        get{ return hostInfo! }
    }
    var frips:[Frip] = []
    var comments:[FripComment] = []
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
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
        collectionView.register(UINib(nibName: "HostButtonCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "HostButtonCollectionViewCell")
        collectionView.register(UINib(nibName: "CommentShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommentShowCollectionViewCell")
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        CommonGetDataManager().getHostInfo(targetURL: URL(string: Constant.HOST)!, hostIdx: hostIdx, header: jwt, vc: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getHostInfo(_ result: HostInfo) {
        self.host = result
        print(host)
        
        collectionView.reloadSections(IndexSet(integer: 0))
        collectionView.reloadSections(IndexSet(integer: 1))
        DispatchQueue.global(qos: .userInitiated).sync { CommonGetDataManager().getHostFrips(targetURL: URL(string: Constant.HOST)!, hostIdx: hostIdx, header: jwt, vc: self) }
    }
    
    func getFrips(_ result: [Frip]) {
        for r in result { frips.append(r) }
        collectionView.reloadSections(IndexSet(integer: 3))
    }
    
    func getFripDetail(_ result: FripDetailInfo,_ index: Int) {
        let vc = FripShowViewController(index, result)
        vc.tabBarController?.tabBar.isHidden = true
        vc.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
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
            return 1
        } else {
            if showOption == 0{
                return frips.count
            } else {
                return comments.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostCollectionViewCell", for: indexPath) as! HostCollectionViewCell
            if hostInfo != nil {
                cell.hostIdx = hostIdx
                do {
                    let url = URL(string: host.hostProfileImg)!
                    let data = try Data(contentsOf: url)
                    cell.image.image = UIImage(data: data)
                } catch { print("image error") }
                if host.hostLike == "Y" {
                    cell.save = true
                    cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                    cell.bookmarkButton.tintColor = UIColor.saveColor
                } else {
                    cell.save = false
                    cell.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                    cell.bookmarkButton.tintColor = UIColor.lightGray
                }
                cell.hostNameLabel.text = host.hostName
                cell.hostCountLabel.text = "프립\(host.hostFripCnt)개 | 후기\(host.hostReviewCnt)개 | 저장\(host.hostLikeCnt)개"
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostTextCollectionViewCell", for: indexPath) as! HostTextCollectionViewCell
            if hostInfo != nil {
                cell.hostDescriptionView.text = host.hostIntroduction
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostButtonCollectionViewCell", for: indexPath) as! HostButtonCollectionViewCell
            cell.label.text = buttonText[indexPath.row]
            if indexPath.row == showOption { cell.label.font = UIFont.NotoSans(.bold, size: 20) }
            else {
                cell.label.font = UIFont.NotoSans(.medium, size: 20)
                cell.label.textColor = .lightGray
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            if frips.count != 0 {
                let frip = frips[indexPath.row]
                let url = URL(string: frip.fripPhotoUrl)
                cell.image.kf.setImage(with: url)
                cell.saveButton.tag = frip.fripIdx
                if frip.fripLike == "Y" {
                    cell.saveButton.tag = cell.saveButton.tag * 10 + 1
                    cell.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                    cell.saveButton.tintColor = UIColor.saveColor
                } else {
                    cell.saveButton.tag = cell.saveButton.tag * 10 + 0
                    cell.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                    cell.saveButton.tintColor = .lightGray
                }
                cell.idx = frip.fripIdx
                cell.place.text = frip.place
                cell.price.text = frip.price
                cell.point.text = frip.rate
                cell.shortDescription.text = frip.fripHeader
                cell.title.text = frip.fripTitle
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
            CommonGetDataManager().getHostFrip(targetURL: URL(string: Constant.ALL_FRIP)!, index: cell.idx, header: jwt, vc: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 120)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 180)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 45)
        case 3:
            return CGSize(width: collectionView.frame.width / 2 - 5, height: 300)
        default:
            return CGSize(width: collectionView.frame.width, height: 0)
        }
    }
}
