//
//  FripShowViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit

class FripShowViewController: BaseViewController {
    
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    let identifier = ["FripImageCollectionViewCell","FripShowCollectionViewCell","HostCollectionViewCell","FripCommentCollectionViewCell","FripIntroCollectionViewCell","FripCommonCollectionViewCell"]
    var count: Int = 0
    var isSave: Bool =  false
    var fripIdx: Int = 0
    var fripDetail: FripDetailInfo?
    var detail: FripDetailInfo {
        get { return self.fripDetail! }
        set (newVal) { self.fripDetail = newVal }
            
    }
    
    init(_ fripIdx:Int, _ fripDetailInfo: FripDetailInfo) {
        self.fripIdx = fripIdx
        fripDetail = fripDetailInfo
        super.init(nibName: "FripShowViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.frame.size = CGSize(width: 25, height: 25)
        joinButton.cornerRadius = 5
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.font = UIFont.NotoSans(.regular, size: 8)
        countLabel.text = "\(detail.fripLikeUserCnt)"
        count = detail.fripLikeUserCnt
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(homeButtonTap))
        self.navigationItem.rightBarButtonItem?.tintColor = .black

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registerCell(collectionView)
        collectionView.register(FripCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FripCollectionReusableView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        if detail.fripLike == "Y" {
            isSave = true
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = UIColor.saveColor
        } else {
            isSave = false
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = UIColor.black
        }
    }
    
    @IBAction func joinTouchDownAction(_ sender: Any) {
        let vc = BuyOptionViewController(fripIdx)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func saveButtonTouchDown(_ sender: Any) {
        if isSave == false {
            count += 1
            countLabel.text = "\(count)"
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = UIColor.saveColor
        } else {
            count -= 1
            countLabel.text = "\(count)"
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = UIColor.black
        }
        isSave = !isSave
        HomePostResponse().fripShowSave(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: fripIdx, header: jwt, VC: self)
    }
    
    func registerCell(_ view: UICollectionView!) {
        for idn in identifier {
            view.register(UINib(nibName: idn, bundle: nil), forCellWithReuseIdentifier: idn)
        }
    }
    
    @objc func homeButtonTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showCommentTap(_ sender:UIButton!) {
        let idx = sender.tag
        let vc = FripCommentViewController(fripIdx: idx, rate: detail.rate, commentCount: detail.fripReviewCnt,title:detail.fripTitle)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension FripShowViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! HostCollectionViewCell
            let vc = HostMainViewController(hostIdx: cell.hostIdx)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FripCollectionReusableView", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
            let cell = allCell as! FripImageCollectionViewCell
            let url = URL(string: detail.fripPhotoUrl)
            cell.imageView.kf.setImage(with: url)
            return cell
        case 1:
            let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
            let cell = allCell as! FripShowCollectionViewCell
            cell.titleLabel.text = detail.fripTitle
            cell.priceLabel.text = "\(detail.price)원"
            return cell
        case 2:
            let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
            let cell = allCell as! HostCollectionViewCell
            let url = URL(string: detail.profileImgUrl)
            cell.image.kf.setImage(with: url)
            cell.hostIdx = detail.hostIdx
            cell.hostNameLabel.text = detail.hostName
            cell.hostCountLabel.text = "프립\(detail.hostFripCnt) | \(detail.fripReviewCnt) | 저장\(detail.fripLikeUserCnt)"
            if detail.fripLike == "Y" {
                cell.save = true
                cell.bookmarkButton.tintColor = UIColor.saveColor
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            else {
                cell.save = false
                cell.bookmarkButton.tintColor = UIColor.lightGray
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            return cell
        case 3:
            let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
            let cell = allCell as! FripCommentCollectionViewCell
            cell.button.tag = fripIdx
            cell.rateLabel.text = detail.rate
            cell.descriptionLabel.text = detail.fripReviewPercent
            cell.commentLabel.text = detail.fripReviewCnt
            if detail.fripReviewCnt == "0개 후기" {
                cell.button.isHidden = true
            } else {
                cell.button.setTitle("\(detail.fripReviewCnt) 보러 가기", for: .normal)
                cell.button.addTarget(self, action: #selector(showCommentTap(_:)), for: .touchDown)
            }
            return cell
        case 4:
            let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
            let cell = allCell as! FripIntroCollectionViewCell
            cell.descriptionTextView.adjustsFontForContentSizeCategory = true
            cell.descriptionTextView.text = detail.fripIntroduction
            
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FripCommonCollectionViewCell", for: indexPath) as! FripCommonCollectionViewCell
            cell.titleLable.text = "포함사항"
            cell.textView.text = detail.includeThing
            cell.border.backgroundColor = .lightGray
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FripCommonCollectionViewCell", for: indexPath) as! FripCommonCollectionViewCell
            cell.titleLable.text = "불포함 사항"
            cell.textView.text = detail.exceptThing
            cell.border.backgroundColor = .lightGray
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FripCommonCollectionViewCell", for: indexPath) as! FripCommonCollectionViewCell
            cell.titleLable.text = "준비물"
            cell.textView.text = detail.preparation
            cell.border.backgroundColor = .lightGray
            return cell
        case 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FripCommonCollectionViewCell", for: indexPath) as! FripCommonCollectionViewCell
            cell.titleLable.text = "유의 사항"
            cell.textView.text = detail.notice
            cell.border.backgroundColor = .lightGray
            return cell
        case 9:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FripCommonCollectionViewCell", for: indexPath) as! FripCommonCollectionViewCell
            cell.titleLable.text = "진행 장소"
            cell.textView.text = detail.meetingPlace
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 400)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 150)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 120)
        case 3:
            if detail.fripReviewCnt == "0개 후기" {
                return CGSize(width: collectionView.frame.width, height: 120)
            } else {
                return CGSize(width: collectionView.frame.width, height: 150)
            }
        case 4:
            return CGSize(width: collectionView.frame.width, height: 500)
        case 5:
            return CGSize(width: collectionView.frame.width, height: 200)
        case 6:
            return CGSize(width: collectionView.frame.width, height: 200)
        case 7:
            return CGSize(width: collectionView.frame.width, height: 200)
        case 8:
            return CGSize(width: collectionView.frame.width, height: 200)
        case 9:
            return CGSize(width: collectionView.frame.width, height: 150)
        default:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 3:
            return CGSize(width: collectionView.frame.width, height: 10)
        case 4:
            return CGSize(width: collectionView.frame.width, height: 10)
        default:
            return CGSize(width: collectionView.frame.width, height: 0)
        }
    }
    
}
