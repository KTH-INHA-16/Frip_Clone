//
//  FripShowViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit

class FripShowViewController: BaseViewController {
    
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    let identifier = ["FripImageCollectionViewCell","FripShowCollectionViewCell","HostCollectionViewCell","FripCommentCollectionViewCell","FripIntroCollectionViewCell"]
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

    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBar.frame.size = CGSize(width: view.frame.width, height: 60)
        saveButton.frame.size = CGSize(width: 25, height: 25)
        joinButton.cornerRadius = 5
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        registerCell(collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if detail.fripLike == "Y" {
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = UIColor.saveColor
        } else {
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = UIColor.black
        }
    }
    
    @IBAction func saveButtonTouchDown(_ sender: Any) {
        if detail.fripLike == "Y" {
            detail.fripLike = "N"
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = UIColor.saveColor
        } else {
            detail.fripLike = "Y"
            saveButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = UIColor.black
        }
        HomePostResponse().fripShowSave(targetUrl: URL(string: Constant.ALL_FRIP)!, idx: fripIdx, header: jwt, VC: self)
    }
    
    func registerCell(_ view: UICollectionView!) {
        for idn in identifier {
            view.register(UINib(nibName: idn, bundle: nil), forCellWithReuseIdentifier: idn)
        }
    }
    
    @objc func saveButtonTap(_ sender:UIButton!) {
        let hostIdx = sender.tag / 10
        let state = sender.tag % 10
        
        if state == 1 {
            sender.tag = hostIdx * 10
            sender.tintColor = UIColor.saveColor
            sender.borderColor = UIColor.saveColor
            sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            sender.tag = hostIdx * 10 + 1
            sender.tintColor = UIColor.lightGray
            sender.borderWidth = 0.5
            sender.borderColor = UIColor.gray
            sender.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        //CommonPostDataManager().hostLikePost(targetUrl: URL(string: Constant.HOST), idx: hostIdx, header: jwt, VC: self)
        //구현되면 추가
    }
    
    @objc func showCommentTap(_ sender:UIButton!) {
        let idx = sender.tag
        let vc = FripCommentViewController(fripIdx: idx)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension FripShowViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let allCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier[indexPath.section], for: indexPath)
        switch indexPath.section {
        case 0:
            let cell = allCell as! FripImageCollectionViewCell
            do {
                var str = detail.fripPhotoUrl
                for _ in 0...3 { str.removeFirst() }
                let url = URL(string: "https"+str)!
                let data = try Data(contentsOf: url)
                cell.imageView.image = UIImage(data: data)
            } catch { print("image load error") }
            return cell
        case 1:
            let cell = allCell as! FripShowCollectionViewCell
            cell.titleLabel.text = detail.fripTitle
            cell.priceLabel.text = "\(detail.price)원"
            return cell
        case 2:
            let cell = allCell as! HostCollectionViewCell
            do {
                var str = detail.profileImgUrl
                for _ in 0...3 { str.removeFirst() }
                let url = URL(string: "https"+str)!
                let data = try Data(contentsOf: url)
                cell.image.image = UIImage(data: data)
            } catch { print("image load error") }
            cell.hostIdx = detail.hostIdx
            cell.hostNameLabel.text = detail.hostName
            cell.hostCountLabel.text = "프립\(detail.hostFripCnt) | 후기\(detail.fripReviewCnt) | 저장\(detail.fripLikeUserCnt)"
            var tag = detail.hostIdx
            if detail.fripLike == "Y" {
                tag = tag * 10 + 1
                cell.bookmarkButton.tintColor = UIColor.saveColor
                cell.borderColor = UIColor.saveColor
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            else {
                tag = tag * 10
                cell.bookmarkButton.tintColor = UIColor.lightGray
                cell.borderWidth = 0.5
                cell.borderColor = UIColor.gray
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            cell.bookmarkButton.tag = tag
            cell.bookmarkButton.addTarget(self, action: #selector(saveButtonTap(_:)), for: .touchDown)
            return cell
        case 3:
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
            let cell = allCell as! FripIntroCollectionViewCell
            cell.descriptionTextView.adjustsFontForContentSizeCategory = true
            cell.descriptionTextView.text = detail.fripIntroduction
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
            return CGSize(width: collectionView.frame.width, height: 180)
        default:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
}
