//
//  FripCommentViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/08.
//

import UIKit

class FripCommentViewController: BaseViewController {
    
    var fripTitle:String = ""
    var fripIdx:Int = 0
    var commentIdx: Int = 0
    var commentCount: String = ""
    var rate: String = ""
    var comments: [FripComment] = []
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    init(fripIdx: Int,rate:String,commentCount: String, title: String) {
        self.fripIdx = fripIdx
        self.commentCount = commentCount
        self.rate = rate
        self.fripTitle = title
        super.init(nibName: "FripCommentViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("eariler \(fripIdx)")
        self.navigationController?.navigationItem.title = "후기"
        self.tabBarController?.tabBar.isHidden = true
        
        collectionView.register(UINib(nibName: "CommentHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommentHeaderCollectionViewCell")
        collectionView.register(UINib(nibName: "CommentShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommentShowCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "후기"
        collectionView.reloadData()
        indicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonGetDataManager().getFripComments(targetURL: URL(string: Constant.ALL_FRIP)!, index: fripIdx, start: commentIdx, end: commentIdx+500, header: jwt, vc: self)
    }

    func getComments(_ result: [FripComment]) {
        for r in result {
            comments.append(r)
        }
        print("comments.count:\(comments.count)")
        var indexPaths: [NSIndexPath] = []
        for index in commentIdx..<commentIdx+result.count {
            indexPaths.append(NSIndexPath(item: index, section: 1))
        }
        commentIdx += result.count
        collectionView.insertItems(at: indexPaths as [IndexPath])
        collectionView.reloadItems(at: indexPaths as [IndexPath])
        
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}

extension FripCommentViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return comments.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentHeaderCollectionViewCell", for: indexPath) as! CommentHeaderCollectionViewCell
            cell.countLabel.text = commentCount
            cell.rateAverageLabel.text = rate
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentShowCollectionViewCell", for: indexPath) as! CommentShowCollectionViewCell
            if comments.count > 0 {
                let url = URL(string: comments[indexPath.row].fripReviewUserProfileImg)
                cell.userImage.kf.setImage(with: url)
                cell.userNameLabel.text = comments[indexPath.row].fripReviewUserNickname
                cell.userRateLabel.text = comments[indexPath.row].rate
                cell.userRateLabel.sizeToFit()
                cell.userCommentView.text = comments[indexPath.row].fripReview
                cell.userDateLabel.text = comments[indexPath.row].fripReviewTime
                cell.userDateLabel.sizeToFit()
                cell.fripTitleLabel.text = fripTitle
                cell.fripOptionLabel.text = comments[indexPath.row].userBuyFripOption
                cell.goodButton.setTitle("도움이 됐어요\(comments[indexPath.row].fripReviewLikeCnt)", for: .normal)
                cell.fripIdx = self.fripIdx
                cell.reviewIdx = comments[indexPath.row].fripReviewIdx
                cell.likeCount = comments[indexPath.row].fripReviewLikeCnt
                if comments[indexPath.row].fripReviewPhotoUrl != "null" {
                    cell.commentImage.isHidden = false
                    let url = URL(string: comments[indexPath.row].fripReviewPhotoUrl)
                    cell.commentImage.kf.setImage(with: url)
                } else {
                    cell.commentImage.isHidden = true
                }
                if comments[indexPath.row].hostIdx != -1 {
                    let url = URL(string: comments[indexPath.row].hostProfileImg)
                    cell.hostImage.kf.setImage(with: url)
                    cell.hostNameLabel.text = comments[indexPath.row].hostName
                    cell.hostDateLabel.text = comments[indexPath.row].fripReviewCommentTime
                    cell.hostNameLabel.sizeToFit()
                    cell.hostDateLabel.sizeToFit()
                    cell.hostCommentView.text = comments[indexPath.row].fripReviewComment
                }
                cell.goodButton.setTitle("도움이 됐어요\(cell.likeCount)", for: .normal)
                if comments[indexPath.row].fripReviewLike == "Y" {
                    cell.isSave = true
                    cell.goodButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                    cell.goodButton.tintColor = .systemBlue
                    cell.goodButton.setTitleColor(.systemBlue, for: .normal)
                } else {
                    cell.isSave = false
                    cell.goodButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                    cell.goodButton.tintColor = .lightGray
                    cell.goodButton.setTitleColor(.lightGray, for: .normal)
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 160)
        } else {
            if comments.count > 0 {
                if comments[indexPath.row].hostIdx == -1 {
                    if comments[indexPath.row].fripReviewPhotoUrl == "null" {
                        return CGSize(width: collectionView.frame.width, height: 260)
                    } else {
                        return CGSize(width: collectionView.frame.width, height: 348)
                    }
                } else {
                    return CGSize(width: collectionView.frame.width, height: 510)
                }
            } else {
                return CGSize(width: collectionView.frame.width, height: 0)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //CommonGetDataManager().getFripComments(targetURL: URL(string: Constant.ALL_FRIP)!, index: fripIdx, start: commentIdx, end: commentIdx+10, header: jwt, vc: self)
    }
}
