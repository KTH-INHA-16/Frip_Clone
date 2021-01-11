//
//  FeedViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/03.
//

import UIKit

class FeedViewController: BaseViewController {
//280 -> 높이
    @IBOutlet weak var collectionView: UICollectionView!
    var feeds: [Feed] = []
    var fripTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "프립 피드"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        FeedGetDataManager().getAllFeed(targetURL: Constant.ALL_FEED, vc: self)
        
        collectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCollectionViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.title = "프립 피드"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.title = "프립 피드"
    }
    
    func getResult(_ result:[Feed]) {
        feeds = result
        for feed in feeds {
            FeedGetDataManager().getFripTitle(targetURL: Constant.ALL_FRIP, fripIdx: feed.fripIdx, vc: self)
        }
    }
    
    func getTitleResult(_ result:String) {
        fripTitles.append(result)
        if fripTitles.count == feeds.count {
            collectionView.reloadData()
        }
    }
    
    func getResult(_ result:FripDetailInfo,_ idx: Int){
        let vc = FripShowViewController(idx, result)
        vc.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goShowFrip(_ sender: UIButton!) {
        let idx = sender.tag
        FeedGetDataManager().goShowFrip(targetURL: Constant.ALL_FRIP, fripIdx: idx, vc: self)
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
        if feeds.count != 0{
            cell.feedIdx = feeds[indexPath.row].feedIdx
            cell.userIdx = feeds[indexPath.row].userIdx
            cell.feedLikeCnt = feeds[indexPath.row].feedLikeCnt
            cell.feedCommentCnt = feeds[indexPath.row].feedCommentCnt
            cell.commentView.text = feeds[indexPath.row].feed
            cell.userName.text = feeds[indexPath.row].userNickname
            cell.userDate.text = feeds[indexPath.row].feedTime
            cell.fripIdx = feeds[indexPath.row].fripIdx
            cell.fripTitle.setTitle(fripTitles[indexPath.row], for: .normal)
            cell.fripTitle.tag = cell.fripIdx
            cell.fripTitle.addTarget(self, action: #selector(goShowFrip(_:)), for: .touchDown)
            cell.userDate.sizeToFit()
            cell.userName.sizeToFit()
            cell.feedImage.kf.setImage(with: URL(string: feeds[indexPath.row].feedPhoto))
            cell.userImage.kf.setImage(with: URL(string: feeds[indexPath.row].userProfileImg))
            cell.likeButton.setTitle("\(cell.feedLikeCnt)", for: .normal)
            cell.messageButton.setTitle("\(cell.feedCommentCnt)", for: .normal)
            if feeds[indexPath.row].feedLike == "Y" {
                cell.isLike = true
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.likeButton.tintColor = .red
            } else {
                cell.isLike = false
                cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.likeButton.tintColor = .black
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width + 290)
    }
    
    
}
